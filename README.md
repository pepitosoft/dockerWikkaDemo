# WikkaWiki docker container
WikkaWiki is a flexible, standards-compliant and lightweight wiki engine written in PHP, which uses MySQL to store pages.
[[http://wikkawiki.org/HomePage]]

## To run image:

~~~~bash
docker run -d -p 80:80 oems/wikkawiki
~~~~
The default database:
~~~~text
wikka
~~~~
    default user:
~~~~text
wikka
~~~~
default password:
~~~~text
wikka-password
~~~~


## Mounting the database file volume

Using your own database (make backup of your original database before to load this docker):
~~~~bash
docker run -d -p 80:80 -v $PWD/mysql:/var/lib/mysql oems/wikkawiki
~~~~

## Build your own:

Modify the mysql_wikkawiki.sql with your own user and database definitions and build the image:
~~~~bash
docker build -t "wikkawiki" .
~~~~

## History

TODO: Write history

## Credits

All WikkaWiki develops.
[[http://wikkawiki.org/CreditsPage]]

## License

GNU General Public License
