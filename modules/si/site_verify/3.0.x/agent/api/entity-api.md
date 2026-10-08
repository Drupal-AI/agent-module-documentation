<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity API and internals

No services are meant to be called directly by other modules; the module's public surface is
the `site_verification` config entity and its storage/routing side effects.

## `SiteVerificationInterface` (implemented by `Drupal\site_verify\Entity\SiteVerification`)

| Method | Returns | Notes |
|---|---|---|
| `getType()` | `SiteVerificationType` enum (`Meta` or `File`) | Defaults to `Meta` if the raw `type` property is empty |
| `getName()` | `string` | Raw `name` field (meta-tag name or filename) |
| `getMetaName()` | `string` | Same as `getName()` but **throws `\InvalidArgumentException`** if `type` != `meta` |
| `getFilename()` | `string` | Same as `getName()` but **throws `\InvalidArgumentException`** if `type` != `file` |
| `getContent()` | `string` | Meta `content` attribute value or file body text |
| `getDescription()` | `string` | Admin note |
| `isValid()` | `bool` | Runs `validate()` once (cached) and returns whether it passed |
| `validate()` | `array` of `ConstraintViolation` | Runs the entity's typed-data validation (schema + `FullyValidatable` + the unique-file constraint); empty array = valid |

`preSave()` always (re)validates and **throws `\LogicException('Entity is not valid, cannot be
saved.')`** if invalid, so `->save()` is a safe way to enforce validity from code.

## Route rebuilding (`SiteVerificationStorage`)

`Drupal\site_verify\Entity\SiteVerificationStorage` (the entity's storage handler, wraps
`ConfigEntityStorage`) implements `SiteVerificationStorageInterface::triggerRouteRebuild()`,
which calls `router.builder`'s `rebuild()`. `SiteVerification::postSave()` and
`::postDelete()` both call this, so **saving or deleting any verification immediately rebuilds
the router** — this is what makes a newly-added `file` verification's serving route work
without a manual cache rebuild, and removes the route as soon as a `file` verification is
deleted or its type is changed away from `file`.

## Dynamic file-serving routes

`Drupal\site_verify\Routing\SiteVerifyRoutes::routes()` (registered via
`route_callbacks` in `site_verify.routing.yml`) queries all `site_verification` entities with
`status = TRUE` and `type = file`, and for each one adds a route named
`site_verify.<filename>` whose path is the filename itself, with
`_controller: \Drupal\site_verify\Controller\SiteVerifyController::verificationsFileContent`
and `_access: 'TRUE'` (publicly accessible — required, since search engines fetch it
unauthenticated). The controller loads the entity by the `svid` route default, 404s
(`NotFoundHttpException`) if it's missing or not `type: file`, and returns a `CacheableResponse`
of `getContent()` as `text/plain`, with the entity and the `site_verify` cache tag attached as
cacheable dependencies.

## Front-page meta tags

`Drupal\site_verify\Hook\SiteVerifyHooks::addVerifications()` (`#[Hook('page_attachments')]`)
runs on every page attachment build but returns immediately unless
`PathMatcherInterface::isFrontPage()` is true. On the front page it loads all `status = TRUE`,
`type = meta` verifications and attaches one `html_tag` render element per verification to
`#attached.html_head`, plus each verification's cache tags and a shared `site_verify` cache tag
on the page.

## Validation constraint

`Drupal\site_verify\Plugin\Validation\Constraint\SiteVerifyUniqueFileConstraint` (id
`SiteVerifyUniqueFile`, applied to the `name` schema field) plus its validator query storage
for any other `site_verification` entity with `type: file` and the same `name`; a match adds a
violation `"Filename %filename is already in use by another site verification."`. This is a
constraint plugin the module *implements* against core's existing typed-data constraint
system — it does not define a new plugin manager/type of its own.
