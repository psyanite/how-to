# Create heroku
heroku create

# Set app
heroku git:remote -a <app>

# Deploys master into heroku
git push heroku master

# Open deployed app in browser
heroku open

# View heroku logs
heroku logs --tail

# Check process status
heroku ps

# Run heroku locally
heroku local web

# See configs
heroku config

# Set a config
heroku config:set TIMES=2
# Configs can also be set in .env file

# Start a console
heroku run bash
