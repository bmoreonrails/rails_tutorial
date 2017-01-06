#Bmore On Rail Workshop Tutorial

This site is created using [jekyll](https://jekyllrb.com/). If you're struggling to find information here, more can be found there.

##Contributing

If you're interested in contributing YAY! and THANK YOU! Please fork this repo and submit any changes as a pull request. 

##Up and Running

Before you get started, make sure you have Ruby 2.x installed locally.

Then, clone the repo and run `bundle install`.

Now, you can get the site up and running locally by running `jekyll serve`. You can view the running site by going to [http://localhost:4000/rails_tutorial/](http://localhost:4000/rails_tutorial/).

## Caveats

### Links
The config value `open_links_in_new_tab` in `config.yml` results in all links opening in a new tab. You can override this behavior on individual links by setting the target attribute back to the default value (`_self`) or if you just don't want the thing to work that way, remove that config value or set it to false.

##Deploying

Because we use custom plugins that Github-pages doesn't support, you must compile the page locally and deploy the contents of the _site directory only to the gh-pages branch using the following steps: 

Deploying is a little dangerous with the jekyll site because there is no versioning on the gh-pages branch. So please be super thoughtful before pushing changes. 

1. Delete your local copy of the gh-pages branch if you already have one. `git branch -D gh-pages`
1. `git checkout master`
1. `git pull origin master`
1. `git checkout -b gh-pages`
1. `jekyll build`
1. `rm -rf _config.yml _layouts _scss about.md index.md _chapters _includes _plugins css js Gemfile.lock Gemfile`
1. `mv _site/* .`
1. `rm -rf _site/`
1. `git add .`
1. `git commit -m "Your commit message"`
1. `git push origin gh-pages -f`
