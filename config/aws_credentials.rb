work_credentials = {
   credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY'], ENV['AWS_SECRET_KEY'])
}

jacinda_credentials = {
   credentials: Aws::Credentials.new(ENV['JACINDA_AWS_ACCESS_KEY'], ENV['JACINDA_AWS_SECRET_KEY'])
}

Aws.config.update(work_credentials)
