data "template_file" "buildspec_infrastructure" {
  template = file("../App/infrastructure/buildspec.yml")
  vars = {
    env  = var.env
  }
}

resource "aws_codebuild_project" "infrastructure" {
  name          = "tf-infrastructure"
  description   = "Plan stage for terraform"
  service_role  = aws_iam_role.tf-codebuild-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "hashicorp/terraform:0.14.3"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"
  }
  source {
    type   = "CODEPIPELINE"
    buildspec = data.template_file.buildspec_infrastructure.template
  }
}

resource "aws_codepipeline" "codepipeline" {
  name     = "tf-test-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = var.artifacts_bucket_name
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      run_order        = 1
      version          = "2"
      input_artifacts  = []
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn        = aws_codestarconnections_connection.github_connection.arn
        OAuthToken           = var.github_token
        Owner                = var.repository_owner
        Repo                 = var.repository_name
        Branch               = "main"
        PollForSourceChanges = "false"
      }

    }
  }
  stage {
    name ="Infrastructure"
    action{
      name = "Build"
      category = "Build"
      provider = "CodeBuild"
      version = "1"
      owner = "AWS"
      input_artifacts = ["source_output"]
      configuration = {
        ProjectName = "tf-infrastructure"
      }
    }
  }
}