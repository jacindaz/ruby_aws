learnup_credentials = {
   credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY'], ENV['AWS_SECRET_KEY'])
}

# can add in more credentials for different IAM users here

Aws.config.update(learnup_credentials)
