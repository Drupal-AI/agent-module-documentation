# JSON:API Response Alter — manual setup guide

**JSON:API Response Alter** (`jsonapi_response_alter`) is a small developer module
that gives your own code a single, clean place to modify the body of any **JSON:API**
response just before Drupal sends it. It provides a hook
(`hook_jsonapi_response_alter`) and an equivalent event
(`JsonApiResponseAlterEvent`) that hand you the decoded JSON document so you can
add, remove, or rewrite keys — without having to override JSON:API's normalizers.

It's the module you reach for in a decoupled build when you need to, for example,
inject a top‑level `meta` key (build info, feature flags, timestamps), append a
computed or aggregate value alongside the raw attributes, strip or rename keys a
particular front end doesn't want, add computed links or signed URLs, or reshape a
payload to match a legacy client's expected format. Rather than scattering custom
normalizers around, you get one hook/event to post‑process all JSON:API output.

The module ships **no default behavior** and has **no configuration**, no
permissions, and no Drush commands — it does nothing until you (or another module)
implement its hook or subscribe to its event. It requires only core's **JSON:API**
module, on Drupal 10.1+ or 11.

> **Important security note for implementers.** The hook and event run on the
> **final, already‑serialized** JSON:API output — *after* JSON:API has applied its
> entity/field access filtering. That means you only receive data the requester was
> already allowed to see (good), **but nothing re‑checks access on anything you
> inject**. If your implementation copies in field values, entity data, or secrets,
> you are responsible for access‑checking them yourself — treat additions as
> bypassing JSON:API's access layer. Also, since the body is re‑encoded but
> cacheability metadata isn't adjusted, make sure any request‑varying additions
> carry appropriate cache contexts/tags on the underlying response.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — there is no settings page or menu item. This is a code‑level extension
point; you use it by writing a hook implementation or an event subscriber in your
own module.

## How to use it

Enable the module, then implement one of the two equivalent APIs in a custom
module.

**Option A — the hook:**

```php
use Symfony\Component\HttpFoundation\Response;

/**
 * Implements hook_jsonapi_response_alter().
 */
function mymodule_jsonapi_response_alter(array &$jsonapi_response, Response $response) {
  // $jsonapi_response is the decoded JSON body (an associative array).
  $jsonapi_response['meta']['generated'] = \Drupal::time()->getRequestTime();
  // unset($jsonapi_response['data'][0]['attributes']['internal_note']);
}
```

**Option B — the event** (subscribe to `JsonApiResponseAlterEvent`, if you prefer
OOP/dependency injection). The event object exposes public properties
`jsonapiResponse` (the decoded array) and `response` (the Symfony `Response`).

Both run only on JSON:API routes. The hook fires first, then the event, so later
implementations see earlier ones' changes. If the response body doesn't decode to
an array, it is left untouched. See the [`agent/`](../agent/start.md) hook docs for
the full event example and mechanics.
