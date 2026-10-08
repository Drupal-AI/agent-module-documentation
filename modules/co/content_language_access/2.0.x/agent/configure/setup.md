# content_language_access — configuration

Admin form: **`content_language_access.admin_form`** at
`/admin/config/regional/content_language_access` (*Config → Regional → Content language access*),
permission `administer content_language_access settings`. Config object:
`content_language_access.settings`.

## What the form controls

- **Permissions matrix** — for every enabled, non-locked language it renders a `details` group with
  one checkbox per (other) language. Checking `en → pt` means: when the negotiated language is `en`,
  a `pt` node is still allowed. The same-language checkbox is disabled and forced on. Each checkbox
  is saved under a config key **`{siteLangcode}_{contentLangcode}`** (boolean).
- **Bypass language access validation** (`access_bypass`, boolean) — master switch for the route
  bypass.
- **Routes to be bypassed** (`route_list`) — a textarea (one route name per line). Stored as a
  sequence of trimmed strings (`ContentLanguageAccessConfigManager::encodeArray()` splits on
  newlines; `decodeArray()` re-joins for the form).

Example config:

```yaml
# content_language_access.settings.yml
en_pt: true          # allow Portuguese nodes while browsing in English
pt_en: false
access_bypass: true
route_list:
  - entity.node.preview
```

Schema lives in `config/schema/content_language_access.schema.yml`.

## The access logic (`hook_node_access`)

Runs on every node access check. It returns:

1. `AccessResult::neutral()` immediately if the account has `bypass content_language_access`.
2. Otherwise it resolves the current language: the `LanguageInterface::TYPE_CONTENT` language if
   content-language negotiation is enabled, else the current interface language.
3. It only proceeds for **published** nodes and the **`view`** operation. For those it takes the
   translation in the current language (`entity.repository:getTranslationFromContext`) and reads
   that translation's langcode.
4. If the node language is neutral (`und`) or not-applicable (`zxx`) → `neutral()` (allowed).
5. If node language **==** current language → `neutral()` (allowed).
6. If node language **!=** current language, it checks the `{current}_{node}` config flag:
   - flag TRUE → `neutral()` (pairing whitelisted, allowed).
   - flag FALSE →
     - on route `entity.node.content_translation_add` → `neutral()` (don't block translating).
     - if `access_bypass` is on **and** (current route is in `route_list` **or** running under CLI)
       → `neutral()`.
     - otherwise → **`AccessResult::forbidden()`** (403).
7. All other cases → `neutral()`.

Key implications:

- It **only restricts viewing published nodes**. Unpublished nodes, and `update`/`delete`
  operations, are never language-restricted here.
- A denial is a hard `forbidden()` (overrides other modules' "allowed" on the canonical route).
- Because it only ever returns `neutral()` or `forbidden()` (never `allowed()`), it can only *remove*
  access, not grant it.
- No cache metadata is added to the AccessResult; behavior depends entirely on language negotiation.

## Setup checklist

1. Configure language detection at *Config → Regional → Languages → Detection and selection* (URL
   prefix or domain), since this module keys off the negotiated language.
2. Enable the module — mismatch denial is active immediately with no matrix entries.
3. Use the admin form to whitelist any cross-language pairings you actually want, and to set up the
   bypass route list if needed.
