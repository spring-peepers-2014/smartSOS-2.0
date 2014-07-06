## About SmartSOS

SmartSOS is a platform that connects non-profit organizations and donors to get critical supplies to where they are needed. We give organizations the flexibility to specify the items they need and adjust to fluctuating needs, while giving donors instant gratification by allowing them to choose which items they donate. The result is better resource allocation and transparency between donors and organizations. 

## Team Members

- Sahan Pitigala
- Tuan Duong
- Payam Pakmanesh
- Alex Frankel
- Pei Xiong Liu

## Notes

This app has some gem dependencies. Please refer to the gem file and run bundle install after cloning. If you do not have the bundler gem, you must install it first.


## Amazon API

This app requires amazon's product marketing API keys for seeding the database. Please acquire a set of keys from https://affiliate-program.amazon.com/gp/advertising/api/detail/main.html. Never upload the keys directly to github. Create a secrets.yaml file in the config folder to store the keys. The .gitignore file is configured to ignore this secrets file.

## Deployment

smartSOS is configured for deployment to Heroku. For additional instructions, please refer to the Heroku deployment guide (https://devcenter.heroku.com/articles/git). For deployment to other platforms, please refer to documentation provided by the host.

## Technologies

- Ruby v. 2.0
- Rails v. 4.0.0
- Sass
- Bootstrap 3
- Amazon product marketing API


## Database Schema

![Imgur](http://i.imgur.com/FGQoQaC.png)
