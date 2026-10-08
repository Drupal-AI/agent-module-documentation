# Configuration

You manage all the message rewrites on a single configuration screen. Each override
is a pair: the original message Drupal would show, and the replacement you want shown
instead.

## Open the configuration screen

1. Log in as a user who has been granted the module's message-override permission (a
   restricted-access permission — grant it only to trusted administrators).
2. Go to **Configuration → System → Messages override**
   (`/admin/config/system/messages-override`).

## Add a message override

On the form you add an override and fill in two fields:

- **Original message** — the exact text of the message Drupal currently shows.
  Getting this string exactly right matters, which is what the Debug option below is
  for.
- **New message** — the wording you want visitors to see in its place.

Because the module swaps in a custom messenger, your replacement takes effect
wherever that original message would normally be printed — including messages that
are translatable-markup objects, not just plain strings.

## Use Debug to capture exact strings

Finding the precise original text can be fiddly. Turn on the **Debug** option on the
form and, together with the core **dblog** module, the exact message strings are
logged as they pass through. You can then copy the logged string and paste it into
the *Original message* field, so your override matches what Drupal actually emits.
Turn Debug off again once you have captured what you need.

## Two things to keep in mind

- **A replaced message loses its translations.** Core's strings come with community
  translations; your custom replacement starts from nothing. On a multilingual site,
  check how an override interacts with the interface-translation layer before
  rewording anything, or you may end up with an untranslated message where a
  translated one used to appear.
- **Error messages carry meaning that support and logs rely on.** Rewording something
  like "Access denied" into friendlier language helps the visitor, but can make a
  support conversation or a log review harder. Keep enough specificity in the new
  wording that someone can still tell which condition actually fired.

Save the form when you are done, then trigger the relevant message (log in, submit a
form, hit the error path) to confirm your new wording appears.
