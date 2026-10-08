# Linkit integration plugins

Optional. These only do anything if the contrib **Linkit** module (>= 6.0.1; older versions conflict
per `composer.json`) is installed. The module defines no plugin *types* of its own — these are
Linkit plugins.

## Matcher — `entity:media_entity_file_redirect`
`src/Plugin/Linkit/Matcher/MediaEntityFileRedirectMatcher.php` extends Linkit's `EntityMatcher`
(`target_entity = "media"`, label "Media: File Redirect"). Identical to the normal media matcher
except `buildPath()` returns
`Url::fromRoute('media_entity_file_redirect.file_redirect', ['media' => $entity->id()])` — i.e.
`/document/{id}` instead of `/media/{id}`. Add it to a Linkit profile so the autocomplete dialog
offers the document path (and it works even when media canonical paths are disabled).

## Substitution — `media_file_redirect`
`src/Plugin/Linkit/Substitution/MediaFileRedirect.php` implements Linkit's `SubstitutionInterface`
(label "URL that redirects to direct file path"). `getUrl()` returns the same
`media_entity_file_redirect.file_redirect` route URL; `isApplicable()` is true for any entity type
implementing `Drupal\media\MediaInterface`. Select it as the substitution on a Linkit profile's media
matcher to have inserted links resolve through `/document/{id}`.

## Setup (UI)
*Configuration → Content authoring → Linkit profiles* → edit a profile → enable the **Media: File
Redirect** matcher and/or choose the **URL that redirects to direct file path** substitution → attach
the profile to a CKEditor Linkit button.
