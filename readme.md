<p align="center">
    <br />
    <img src="https://shineon-cdn-public.s3.amazonaws.com/shineon-platform-logo.jpg" width="150">
</p>

# Homestead

## Introduction

Laravel Homestead is an official, pre-packaged Vagrant box that provides you a wonderful development environment without requiring you to install PHP, a web server, and any other server software on your local machine. No more worrying about messing up your operating system! Vagrant boxes are completely disposable. If something goes wrong, you can destroy and re-create the box in minutes!

Homestead runs on any Windows, Mac, or Linux system, and includes the Nginx web server, PHP 7.2, MySQL, Postgres, Redis, Memcached, Node, and all of the other goodies you need to develop amazing Laravel applications.

Official documentation [is located here](http://laravel.com/docs/homestead). READ THIS but don't do anything and return back here.

## Changes in this fork.

### Modifications in `/resources` will be scaffolded in `Step 5a`:

> The following has been added to `after.sh`

* `composer install`
* `npm install`

> Some manual stuff for ...

* Setup Imagemagick for php 7.2

## Getting Started

### Step 1: Some installers

1. [Virtual Box 5.1 or higher](https://www.virtualbox.org/)
1. [Vagrant 1.9 or higher](https://www.vagrantup.com/)
1. [Node and NPM](https://nodejs.org/en/download/)

### Step 2: Add your ssh key to Github

1. `ssh-keygen`
1. `cat ~/.ssh/id_rsa.pub`
1. Add your new public key to your [github](https://help.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account) and [1password](https://shineon.1password.com)

### Step 3: Update your hosts file

  * ##### MAC
    1. `sudo nano /private/etc/hosts`
    1. Add the following:
    1. `192.168.10.10 local.api.shineon.com`
    1. `192.168.10.10 local.admin.shineon.com`
    1. `192.168.10.10 local.affiliate.shineon.com`
    1. `192.168.10.10 local.beacon.shineon.com`
    1. `192.168.10.10 local.fulfillment.shineon.com`
    1. `192.168.10.10 local.platform.shineon.com`
    1. `192.168.10.10 local.research.shineon.com`

  * ##### LINUX
    1. `sudo nano /etc/hosts`
    1. Add the following:
    1. `local.api.shineon.com 		    192.168.10.10`
    1. `local.admin.shineon.com 		192.168.10.10`
    1. `local.affiliate.shineon.com 	192.168.10.10`
    1. `local.beacon.shineon.com 		192.168.10.10`
    1. `local.fulfillment.shineon.com 	192.168.10.10`
    1. `local.platform.shineon.com 	    192.168.10.10`
    1. `local.research.shineon.com 		192.168.10.10`
    
### Step 3: Clone Repos (you may not need access to all repos in this list)

```
# beacon.shineon.com
git clone git@github.com:ShineOnCom/Beacon.git ~/beacon.shineon.com
cd ~/beacon.shineon.com
sudo chmod -R 777 storage
sudo chmod -R 777 bootstrap/cache

# api.shineon.com admin.shineon.com affiliate.shineon.com fulfillment.shineon.com platform.shineon.com
git clone git@github.com:ShineOnCom/shopify-app.git ~/fulfillment.shineon.com
cd ~/fulfillment.shineon.com
sudo chmod -R 777 storage
sudo chmod -R 777 bootstrap/cache

# research.shineon.com
git clone git@github.com:ShineOnCom/research.git ~/research.shineon.com
cd ~/research.shineon.com
sudo chmod -R 777 storage
sudo chmod -R 777 bootstrap/cache
```

### Step 4: Environment Files

#### Beacon

```
touch ~/beacon.shineon.com/.env
sudo nano ~/beacon.shineon.com/.env
```

> See [wiki](https://github.com/ShineOnCom/Beacon/wiki)

#### Api, Admin app, Affiliate app, Platform app, Shopify App

```
touch ~/fulfillment.shineon.com/.env
sudo nano ~/fulfillment.shineon.com/.env
```

> See [wiki](https://github.com/ShineOnCom/shopify-app/wiki)

#### Research app

```
touch ~/research.shineon.com/.env
sudo nano ~/research.shineon.com/.env
```

> See [wiki](https://github.com/ShineOnCom/research/wiki)

### Step 5a: Pull down the ShineOn Homestead repo.

1. `vagrant box add laravel/homestead`
1. `git clone https://github.com/ShineOnCom/homestead.git ~/Homestead`
1. `cd ~/Homestead`
1. `bash init.sh`
1. Test vagrant: 
    1. `vagrant up --provision`
    1. `vagrant ssh`
    1. `cd ~/fulfillment.shineon.com`
    1. `php artisan`
    1. Did artisan break? You're almost done...
    1. Run the following manually for now, `after.sh` isn't able to suppress all interactivity.

### DEPRECATED. Step 5b: Vagrant SSH and install Imagick (in `vagrant ssh`)

> THIS STEP MAY BE SKIPPED IF YOU'VE SETUP AFTER MAY 2020

This is annoying, but some commands that we need cannot escape interactivity, figure this out and I'll give you an attaboy.

```
sudo apt-add-repository ppa:ondrej/php
sudo apt-get install -y php7.2-dev pkg-config libmagickwand-dev
sudo pecl install imagick-beta
# keep yours

sudo bash -c 'echo -e "extension=imagick.so\n" >> /etc/php/7.2/mods-available/imagemagick.ini'
sudo ln -sf /etc/php/7.2/mods-available/imagemagick.ini /etc/php/7.2/fpm/conf.d/20-imagemagick.ini
sudo ln -sf /etc/php/7.2/mods-available/imagemagick.ini /etc/php/7.2/cli/conf.d/20-imagemagick.ini
sudo service php7.2-fpm restart
```

### Step 5c: Restart Vagrant

```
vagrant halt && vagrant up --provision
```

### Step 5d: Migrate (first timers only)

> Do not forget to `vagrant ssh && cd ~/app-name-here` first

```
php artisan migrate
```

### Step 6: Test the DB

> The latest homestead box allows you to connect to mysql with your homestead local ip. 

1. Host: `192.168.10.10`
1. Username: `homestead`
1. Password: `secret`
1. Database: `portal` or `fulfillment`
1. Port: 3306

### Step 7: Test the waters

1. Visit [local.admin.shineon.com](http://local.shopify-app.shineon.com)
1. See [shopify-app](https://github.com/ShineOnCom/shopify-app) "Additional Setup"

### Step 8: Add more useful starter data.

Ask your manager for ... 

- Access to `aws-stage` so you may download a more useful starter DB
- A cloned copy of the staging CDN bucket in your name so you've got starter assets
- For a queue on AWS to be setup for you

## Debugging Vagrant Problems

### Did you install Imagick?

<img src="https://shineon-cdn-dan-public.s3.amazonaws.com/docs/homestead-errors-obscured.png" />

We haven't been able to get `after.sh` to handle this without interaction, see the imagick instructions above if you've seen this error.

### Does Composer Dump Autoload fail

The shell output from `after.sh` when composer eats it is not helpful. Try this if you have problems.

<img src="https://shineon-cdn-dan-public.s3.amazonaws.com/docs/homestead-errors-obscured-solution.png" />

### Ubuntu 16.04 Box Issues

Issue:

```shell
Ubuntu 16.04 - system boot waits saying “Raise network interfaces”
```

Solution:

```shell
Modify /etc/dhcp/dhclient.conf Timeout to 15 
```

Issue:

Vagrant setup of network adapters hangs

Solution:

```shell
Make sure that you have checked "Cable Connected" in Virtualbox Network Configuration (Homestead VM configuration)
````

## Asset compilation

Fulfillment uses Laravel 5.8, NPM 6.\~, NPM 3.\~, and Webpack for asset compilation. There is no need install / upgrade Node / NPM. See `package.json` file for most up to date dev commands.

### November 2019 Update

We no longer need to run npm commands inside `vagrant ssh`. This reduces CPU load substantially. Thanks @shinyhiram.

We also have some new dev commands.

- `npm run dev-full` (This may be committed with your work, we `npm run production` in our deployment script now.
- `npm run dev` (just the platform dev build)

#### Most Useful

- `npm run watch-full` (all apps)
- `npm run watch` (just the platform dev build, fastest for platform development)

### Committing / Code Pushes

Before committing code or submitting pull requests on github, be sure you remember to `npm run dev-full`. This is in review right now as we've `npm run production` spikes the CPU on our EC2 servers.

## More Documentation

The wikis for the [various github projects](https://github.com/ShineOnCom/shopify-app) have more information on our stack.

## More Help

Get on slack and ask your mates.

## HOMESTEAD UPGRADE GUIDE (for envs before May 2020)

1. BACKUP YOUR DATABASES
1. `vagrant halt`
1. `vagrant global-status`
1. `vagrant destroy hash-here`
1. Rename `~/Homestead` to `~/HomesteadOld`
1. Open VirtualBox and delete your instances
1. `git clone https://github.com/ShineOnCom/homestead.git ~/Homestead`
1. `cd ~/Homestead`
1. `vagrant up`
