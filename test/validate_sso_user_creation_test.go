package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestValidateSsoUserCreation(t *testing.T) {
	t.Parallel()

	expectedUsername := "unit"

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/basic-usage",

		Vars: map[string]interface{}{
			"name": expectedUsername,
		},

		NoColor: true,
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	actualUsername := terraform.Output(t, terraformOptions, "sso_username")

	assert.Contains(t, actualUsername, expectedUsername)
}
