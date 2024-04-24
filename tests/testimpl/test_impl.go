package testimpl

import (
	"context"
	"strconv"
	"testing"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestComposableComplete(t *testing.T, ctx types.TestContext) {
	lambdaClient := GetAWSLambdaClient(t)

	layerArn := terraform.Output(t, ctx.TerratestTerraformOptions(), "lambda_layer_arn")
	layerVersion := terraform.Output(t, ctx.TerratestTerraformOptions(), "lambda_layer_version")

	t.Run("TestLambdaLayerExists", func(t *testing.T) {
		layer, err := lambdaClient.GetLayerVersionByArn(context.TODO(), &lambda.GetLayerVersionByArnInput{
			Arn: &layerArn,
		})
		if err != nil {
			t.Errorf("Failure during GetLayerVersionByArn: %v", err)
		}

		layerArnWithVersion := *layer.LayerArn + ":" + strconv.FormatInt(layer.Version, 10)
		assert.Equal(t, layerArnWithVersion, layerArn, "Expected ARN did not match actual ARN!")
		assert.Equal(t, strconv.FormatInt(layer.Version, 10), layerVersion, "Expected Version did not match actual Version!")
	})
}

func GetAWSLambdaClient(t *testing.T) *lambda.Client {
	awsLambdaClient := lambda.NewFromConfig(GetAWSConfig(t))
	return awsLambdaClient
}

func GetAWSConfig(t *testing.T) (cfg aws.Config) {
	cfg, err := config.LoadDefaultConfig(context.TODO())
	require.NoErrorf(t, err, "unable to load SDK config, %v", err)
	return cfg
}
