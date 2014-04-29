# Genuineblue tempate application for rails4.1

## Rename application's name

```
git grep -l 'Genuineblue'|xargs sed -i '' 's/Genuineblue/your_app_name/g'
```

## Setup for development

rename Guardfile.example to Guardfile

```
$ cp Guardfile.example Guardfile
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
heroku create Genuineblue
git remote rename heroku Genuineblue
git push Genuineblue master
heroku addons:add newrelic
heroku addons:add pgbackups:auto-month
heroku addons:add mandrill:starter
rake figaro:heroku\[Genuineblue\]
```

### staging

```
heroku create Genuineblue-stg
git remote set-url Genuineblue-stg git@heroku.com:Genuineblue-stg.git
git push Genuineblue master
heroku addons:add newrelic
heroku addons:add pgbackups:auto-month
heroku addons:add mandrill:starter
heroku addons:add mailtrap
heroku config:set RACK_ENV=staging RAILS_ENV=staging
rake figaro:heroku\[Genuineblue-stg\]
```

## s3

create 'Genuineblue' bucket on 'us-east-1'

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
        "arn:aws:s3:::Genuineblue"
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
        "arn:aws:s3:::Genuineblue/*"
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
AWS_S3_BUCKET: 'Genuineblue'
```
