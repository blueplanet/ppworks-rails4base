# appname

## Rename application's name

```
git grep -l 'module Appname'|xargs sed -i '' 's/Appname/Yourappname/g'
git grep -l 'appname'|xargs sed -i '' 's/appname/yourappname/g'
```

## Setup for development

rename Guardfile.example to Guardfile

```
$ cp Guardfile.example Guardfile
$ npm install -g bower
$ bin/rake bower:install
```

## External API Credential

```
cp config/application.yml.example config/application.yml
```

Fill in api credential

```
rake secret
```

Fill in SECRET_TOKEN by the key above result.

```
rake secret
```

Change devise's secret_token(config/initializers/devise.rb) by the key above result.

## Start guard

```
$ guard
```

## heroku

```
heroku create appname
git remote rename heroku appname
git push appname master
heroku addons:add newrelic
heroku addons:add pgbackups:auto-month
heroku addons:add mandrill:starter
rake figaro:heroku\[appname\]
```

### staging

```
heroku create appname-stg
git remote set-url appname-stg git@heroku.com:appname-stg.git
git push appname master
heroku addons:add newrelic
heroku addons:add pgbackups:auto-month
heroku addons:add mandrill:starter
heroku addons:add mailtrap
heroku config:set RACK_ENV=staging RAILS_ENV=staging
rake figaro:heroku\[appname-stg\]
```

## s3

create 'appname' bucket on 'us-east-1'

### IAM

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListBucket",
        "s3:GetBucket*"
      ],
      "Resource": [
        "arn:aws:s3:::appname"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "s3:DeleteObject*",
        "s3:GetObject*",
        "s3:PutObject*"
      ],
      "Resource": [
        "arn:aws:s3:::appname/*"
      ],
      "Effect": "Allow"
    }
  ]
}
```

Fill config/application.yml

```
AWS_ACCESS_KEY_ID: ''
AWS_SECRET_ACCESS_KEY: ''
AWS_REGION: 'us-east-1'
AWS_S3_BUCKET: 'appname'
```
