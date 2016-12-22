# Supported tags and respective `Dockerfile` links

-	[`1.3.7-md1` , `latest` (*Dockerfile*)](https://github.com/oemunoz/wikkawiki/blob/master/Dockerfile)

# [WikkaWiki Markdown Demo docker container](https://github.com/pepitosoft/dockerWikkaDemo)

![WikkaWiki.](https://github.com/oemunoz/wikkawiki/raw/master/images/wikka_logo.jpg)

WikkaWiki is a flexible, standards-compliant and lightweight wiki engine written in PHP, which uses MySQL to store pages.
[[http://wikkawiki.org/HomePage]]
## To run the image:

This is a resumed HowTo, for a long description follow the link to the [WikkaWiki](http://wikkawiki.org/Wikka-Docker).

### To run the default image (new Install):
When you run this docker with the basic minimum options:

```bash
docker run -d -p 80:80 oems/wikkademo
```

- Run out of the box, to install WikkaWikki page.
- Run the latest Version of WikkaWiki (1.3.7), from the website tar.gz.
- Run with PHP 5 (Developer tested).
- A new WikkaWiki database over MySql 5.5 (tested), with the next DB/user/password options.

The default database:

```
wikka
```

default user:

```
wikka
```

default password:

```
wikka-password
```

With this default option, you run the database into the container, then **if you delete your container you delete your database also**, remember to make backup.

### Using your own database files

The internal database use MySql 5.5, using your own database (make backup of your original database before to load this docker):

~~~~bash
docker run -d -p 80:80 -v $PWD/mysql:/var/lib/mysql oems/wikkademo
~~~~

### Using your own database and your own configuration file.

You can use your own configuration options.

~~~~bash
docker run -d -p 80:80 -v $PWD/mysql:/var/lib/mysql -v $PWD/wikka.config.php:/var/www/html/wikka/wikka.config.php oems/wikkademo
~~~~

If you use a external database (with a docker-compose setup for example) you dont need the mysql volume.

~~~~bash
docker run -d -p 80:80 -v $PWD/wikka.config.php:/var/www/html/wikka.config.php oems/wikkademo
~~~~

#### How to get de default an clean database from this docker.

You can to extract the **default** database if you want to use this image into some docker-compose for example:

~~~~bash
docker run --rm -it -v $PWD/mysql_org:/var/lib/mysql oems/wikkademo sh -c "tar -xvf /mysql_basic.tar"
~~~~

### Using your own uploads and your plugins also:

~~~~bash
docker run -d -p 80:80 -v $PWD/mysql:/var/lib/mysql -v $PWD/wikka.config.php:/var/www/html/wikka/wikka.config.php -v $PWD/uploads:/var/www/html/wikka/uploads -v $PWD/plugins:/var/www/html/wikka/plugins oems/wikkademo
~~~~

### Build your own:

Modify the mysql_wikkawiki.sql with your own user and database definitions and build the image:
~~~~bash
git git@github.com:pepitosoft/dockerWikkaDemo.git wikkademo
cd wikkademo
docker build -t "wikkademo" .
~~~~

## History

- 160705: Basic Initial Version.
- 160707: WikkaWiki now uses /wikka not the root of apache, but works out of the box.

## Credits

All WikkaWiki develops.
[[http://wikkawiki.org/CreditsPage]]

## License

GNU General Public License
