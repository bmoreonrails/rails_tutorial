#Bmore On Rail Workshop Tutorial

This site is created using [jekyll](https://jekyllrb.com/). If you're struggling to find information here, more can be found there.

##Contributing

If you're interested in contributing YAY! and THANK YOU! Please fork this repo and submit any changes as a pull request. 

##Up and Running

Before you get started, make sure you have Ruby 2.x installed locally.

Then, clone the repo and run `bundle install`.

Now, you can get the site up and running locally by running `jekyll serve`. You can view the running site by going to [http://localhost:4000/rails_tutorial/](http://localhost:4000/rails_tutorial/). (Note that the trailing slash is **not** optional.)

## Caveats

### Links
The config value `open_links_in_new_tab` in `config.yml` results in all links opening in a new tab. You can override this behavior on individual links by setting the target attribute back to the default value (`_self`) or if you just don't want the thing to work that way, remove that config value or set it to false.

##Deploying

First, checkout master and pull the latest changes.

```sh
git checkout master
git pull origin master
```

Then, run `rake prepare_deploy`.

```sh
rake prepare_deploy
```

When the task finishes, you'll be on the `gh-pages` branch. There will be a new commit for the changes you're deploying. If everything looks good, push the changes.

```sh
git push origin gh-pages
```
