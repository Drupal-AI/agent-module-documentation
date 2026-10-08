# Youtube Gallery — Drush commands

One command, defined in `\Drupal\youtube_gallery\Drush\Commands\YoutubeGalleryCommands`.

## `ytg:libraries` (alias `ytg-libraries`)

Downloads and installs the Google API PHP client, needed only for the optional video-upload feature
(the read/gallery side uses plain HTTP calls and does not need it).

```bash
drush ytg:libraries            # install into DRUPAL_ROOT/libraries
drush ytg:libraries web/libraries   # install into a custom path (relative to root, or absolute)
```

Behavior: fetches `https://github.com/google/google-api-php-client/archive/master.zip` via the core
HTTP client, extracts it, and renames the extracted `google-api-php-client-{main,master}` directory to
`<path>/google-api-php-client`. After installing you typically run `composer install` inside that
directory to pull the client's own dependencies. Returns success/failure exit codes and logs errors.

At runtime `youtube_gallery_load_google_client()` first checks whether `\Google\Client` is already
available (Composer install) and only falls back to a PSR-4 autoloader over
`libraries/google-api-php-client/src` when it is not.

> Note: this is an operator-run command that pulls the library from GitHub `master` (a moving target)
> over HTTPS. Preferring the Composer dependency (`google/apiclient`) gives you a pinned version.
