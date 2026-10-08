# Content-Security-Policy integration (`csp-allow-method`)

Attach Inline has **no settings form and no configure route**. Its only configuration is one key on
the `attachinline.settings` config object, and it only has any effect when the contrib
**`drupal/csp`** module (Content Security Policy, ^2 suggested) is installed and building a policy.

## The one config key

Schema: `config/schema/attacheinline.schema.yml`

```yaml
attachinline.settings:
  type: config_object
  mapping:
    csp-allow-method:
      type: string   # 'hash' | 'nonce'
```

- There is **no `config/install` default**, so the config object does not exist until something
  writes it. The renderers read it defensively as
  `->get('attachinline.settings')->get('csp-allow-method') ?? 'hash'`, so the effective default is
  **`hash`**.
- Set it from the CLI or config sync (there is no UI):

```bash
drush config:set attachinline.settings csp-allow-method nonce   # or: hash
```

## What each method does

Both collection renderers (`JsCollectionRendererDecorator`, `CssCollectionRendererDecorator`) do this
per inline snippet, only when `moduleHandler->moduleExists('csp')`:

- **`hash`** (default): computes `\Drupal\csp\Csp::calculateHash($data)` for the snippet and registers
  it via `CspSubscriber::registerHash()` on directives `script-src` + `script-src-elem` (JS) or
  `style-src` + `style-src-elem` (CSS). No page attribute is added.
- **`nonce`**: adds a `nonce="<value>"` attribute (from the `@?csp.nonce` service,
  `\Drupal\csp\Nonce::getValue()`) to the `<script>`/`<style>` tag and registers the nonce source via
  `CspSubscriber::registerNonce()` on the same directives.

The point of both is to let inline snippets satisfy a strict CSP **without** the policy needing
`'unsafe-inline'`.

## The event subscriber

`attachinline.csp_subscriber` = `Drupal\attachinline\EventSubscriber\CspSubscriber`
(`src/EventSubscriber/CspSubscriber.php`).

- Subscribes to `\Drupal\csp\CspEvents::POLICY_ALTER` at priority **`-10`** (runs late, "in case other
  listeners add `'unsafe-inline'`"). `getSubscribedEvents()` returns `[]` if the `csp` classes are not
  loaded, so the subscriber is inert without the CSP module.
- `onCspPolicyAlter()` appends every registered hash / nonce to its directive through
  `fallbackAwareAppendIfEnabled()`, which: skips a directive that already contains `'unsafe-inline'`
  (adding a hash there would paradoxically *disable* `'unsafe-inline'` and could block other inline
  code), and, if the directive is not set but a fallback (e.g. `default-src`) is, seeds it from the
  fallback before appending.
- `getNonce()` is **deprecated** (attachinline:8.x-1.5, removed in 2.0.0) — use
  `\Drupal\csp\Nonce::getValue()` instead.

## Composer notes

- `composer.json` `suggest`: `drupal/csp` — "Restrict authorized inline code to limit XSS
  vulnerability."
- `conflict`: `drupal/csp < 1.21` (older CSP releases are incompatible with this integration).
- Without the CSP module the snippets still render; they simply carry no hash/nonce and rely on
  whatever (if any) CSP the site otherwise has.
