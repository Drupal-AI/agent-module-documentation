<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Collabora Online (collabora_online) — agent index

Integrates **Collabora Online / CODE** (the LibreOffice-based online office suite) into Drupal so
office documents attached to **media entities** can be **viewed and edited in the browser**. Drupal
acts as the **WOPI host**: it embeds the Collabora editor in an iframe and exposes WOPI endpoints
that the Collabora server calls back to read and write the file. Package `Collabora Online`. Core
`^10 || ^11`. License **MPL-2.0** (packaged with GPL-2.0-or-later docs headers). Installed version
**0.9.0-beta13** (version dir `0.9.x`). Security coverage: **not covered** by the security advisory
policy (beta).

## Dependencies

- Drupal core: **`media`** (documents are `media` entities with a single file field).
- Contrib: **`key`** (the JWT signing secret is a Key entity).
- PHP libraries (composer): **`firebase/php-jwt`** (HS256 access tokens) and **`phpseclib/phpseclib`**
  (RSA verification of the WOPI proof header).
- Optional submodule `collabora_online_group` additionally needs **`group`** + **`groupmedia`**.
- **External runtime requirement:** a running **Collabora Online / CODE server** reachable from
  Drupal; its `discovery.xml` is fetched from `{server}/hosting/discovery`.

## How it works (WOPI round-trip)

1. A user opens `/cool/view/{media}` (read-only) or `/cool/edit/{media}` (edit). Route access is
   gated by `media.preview in collabora` / `media.edit in collabora`.
2. `ViewerController::editor()` fetches the Collabora `discovery.xml` (cached), picks the WOPI client
   URL, mints a short-lived **HS256 JWT access_token** carrying `fid` (media id), `uid`, `wri`
   (write flag) and `exp`, and renders an iframe that auto-posts the token to the Collabora client.
3. The Collabora server calls back to Drupal's **WOPI endpoints** under `/cool/wopi/files/{media}`
   with that token to get file info, download contents, and (on save) upload the edited file.
4. Each WOPI request is authenticated by (a) an **RSA proof signature** proving it came from the
   trusted Collabora server, and (b) the **JWT**, whose signature, expiry and `fid`-binding are
   verified, with write access re-checked live against Drupal permissions before any save.

## What it provides (from source)

- **Routes** (`collabora_online.routing.yml`): `collabora-online.view` (`/cool/view/{media}`),
  `.edit` (`/cool/edit/{media}`), `.modal` (`/cool/modal/{media}`), `.settings`
  (`/admin/config/cool/settings`), and the three WOPI routes `.wopi.info` / `.wopi.contents` (GET) /
  `.wopi.save` (POST) under `/cool/wopi/files/{media}[/contents]`.
- **Controllers**: `ViewerController` (iframe editor page), `ModalController` (modal preview),
  `WopiController` (WOPI info/content/save entry point).
- **Access + tokens**: `Access\WopiProofAccessCheck` (route requirement
  `_collabora_online_wopi_access`), `Jwt\JwtTranscoder` (+ base/interface) for encode/decode.
- **Key type**: `collabora_jwt_hs` ("JWT HMAC - Collabora Online", `Plugin/KeyType/CollaboraJwtHs`) —
  enforces a ≥32-byte HS256 secret; generates 64 random bytes.
- **Discovery**: `Discovery\DiscoveryFetcher` fetches + caches `discovery.xml`; `Discovery\Discovery`
  exposes the WOPI client URL, MIME map and proof keys.
- **Field formatters**: `collabora_preview` (`CoolPreview`), `collabora_preview_embed`
  (`CollaboraPreviewEmbed`), `collabora_preview_modal` (`CollaboraPreviewModal`) — all for
  single-value `file`/`media` fields.
- **Views fields**: `media_collabora_preview` (`CollaboraPreview`), `media_collabora_edit`
  (`CollaboraEdit`) — link fields to open the viewer/editor.
- **Permissions** (`collabora_online.permissions.yml` + `CollaboraMediaPermissions`): global
  `administer collabora instance`, plus four per-media-type permissions (preview / preview own
  unpublished / edit own / edit any … `in collabora`). Access logic in `hook_ENTITY_TYPE_access`
  (`collabora_online.module`).
- **Config** (`collabora_online.settings`): server URL, WOPI base URL, JWT key id, token TTL,
  discovery cache TTL, cert-check toggle, WOPI-proof toggle, fullscreen, new-file-on-save interval.
- **Hooks**: `hook_theme` (3 templates), `hook_entity_operation` (adds "View/Edit in Collabora
  Online" media operations), `hook_requirements` (checks key + server reachability + proof keys).
- **Submodule** `collabora_online_group` — group/groupmedia integration (see below).

## Solution docs

- **Configuration, Key setup, discovery, requirements** → [config/settings.md](config/settings.md)
- **WOPI endpoints, JWT token flow, proof check, viewer/modal controllers, access model** →
  [api/wopi.md](api/wopi.md)
- **Field formatters, Views link fields, media operations, templates** →
  [plugins/display.md](plugins/display.md)
- **Submodule** `collabora_online_group` →
  [modules/collabora_online_group/0.9.x/agent/start.md](../../modules/collabora_online_group/0.9.x/agent/start.md)
