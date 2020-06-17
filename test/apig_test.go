package test

import (
	"fmt"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

func TestAPIG_basic(t *testing.T) {
	t.Parallel()

	apigName := fmt.Sprintf("apig-%s", random.UniqueId())
	exampleDir := "../examples/basic/"

	terraformOptions := SetupExample(t, apigName, exampleDir)
	t.Logf("Terraform module inputs: %+v", *terraformOptions)
	defer terraform.Destroy(t, terraformOptions)

	fmt.Println(os.Getenv("AWS_ACCESS_KEY_ID"))
	fmt.Println(os.Getenv("AWS_SECRET_ACCESS_KEY"))

	TerraformApplyAndValidateOutputs(t, terraformOptions)
}

func SetupExample(t *testing.T, apigName string, exampleDir string) *terraform.Options {

	// localstackConfigDestination := path.Join(exampleDir, "localstack.tf")
	// files.CopyFile("fixtures/localstack.tf", localstackConfigDestination)
	// t.Logf("Copied localstack file to: %s", localstackConfigDestination)

	terraformOptions := &terraform.Options{
		TerraformDir: exampleDir,
		EnvVars: map[string]string{
			"AWS_REGION": "us-east-1",
		},
		Vars: map[string]interface{}{
			"name": apigName,
		},
	}
	return terraformOptions
}

func TerraformApplyAndValidateOutputs(t *testing.T, terraformOptions *terraform.Options) {
	terraformApplyOutput := terraform.InitAndApply(t, terraformOptions)
	resourceCount := terraform.GetResourceCount(t, terraformApplyOutput)

	require.Greater(t, resourceCount.Add, 0)
	require.Equal(t, resourceCount.Change, 0)
	require.Equal(t, resourceCount.Destroy, 0)

	require.NotEqual(t, terraform.Output(t, terraformOptions, "rest_api_id"), "")
	require.NotEqual(t, terraform.Output(t, terraformOptions, "deployment_id"), "")
	require.NotEqual(t, terraform.Output(t, terraformOptions, "deployment_invoke_url"), "")
	require.NotEqual(t, terraform.Output(t, terraformOptions, "deployment_execution_arn"), "")
	require.NotEqual(t, terraform.Output(t, terraformOptions, "url"), "")
}
