resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "my-terraform-dashboard"

  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
         [ "AWS/EC2", "CPUUtilization", "InstanceId", "i-09791f8880384f45c" ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "ap-south-1",
        "title": "EC2 Instance CPU"
      }
    },
    {
      "type": "text",
      "x": 0,
      "y": 7,
      "width": 3,
      "height": 3,
      "properties": {
        "markdown": "Hello world"
      }
    }
  ]
}
EOF
}
