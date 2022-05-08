package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	"github.com/hadenlabs/terraform-aws-iam-s3-user/internal/app/external/faker"
	"github.com/hadenlabs/terraform-aws-iam-s3-user/internal/testutil"
)

func TestFullSuccess(t *testing.T) {
	t.Parallel()

	tags := map[string]interface{}{
		"tag1": "tags1",
	}
	namespace := testutil.Company
	stage := testutil.Stage
	name := faker.Server().Name()
	enabled := true
	useFullName := true
	s3Actions := []string{
		"s3:GetObject",
		"s3:GetObjectAcl",
		"s3:ListObjects",
		"s3:ListBucket",
		"s3:ListAllMyBuckets",
	}
	s3Resources := []string{
		"arn:aws:s3:::bucket-name/*",
	}

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "user-full",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"namespace":    namespace,
			"stage":        stage,
			"name":         name,
			"enabled":      enabled,
			"tags":         tags,
			"use_fullname": useFullName,
			"s3_actions":   s3Actions,
			"s3_resources": s3Resources,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)
	outputUserName := terraform.Output(t, terraformOptions, "user_name")
	assert.NotEmpty(t, outputUserName, outputUserName)
}
