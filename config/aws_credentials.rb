Aws.config.update({
   credentials: Aws::Credentials.new(ENV['JACINDA_AWS_ACCESS_KEY'], ENV['JACINDA_AWS_SECRET_KEY'])
})
