# DFP (Doubleclick for Publishers) — agent index

Injects Google Publisher Tag (`googletag`) JS and ad slots into pages. You define `dfp_tag` config
entities (ad slots) and set global `dfp.settings`; a decorator on the HTML attachments processor
writes the head scripts. Each tag can also be a placeable block. Depends on core `block`. Single
permission `administer DFP` gates everything. Config UI: route `dfp.admin_settings`
(*Structure › DFP Ad Tags › Global settings*, `/admin/structure/dfp/settings`).

- **Global settings keys, the `dfp_tag` entity fields, blocks, short tags, ad-test mode** →
  [configure/settings.md](configure/settings.md)
- **Tokens (`[dfp_tag:*]`) and the four alter hooks** → [api/tokens-and-hooks.md](api/tokens-and-hooks.md)
- **Theme hooks / templates that produce the head scripts and tag markup** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Config object `dfp.settings` (network_id, adunit_pattern, click_url, async_rendering,
  disable_init_load, single_request, default_slug, collapse_empty_divs, hide_slug, targeting,
  adtest_adunit_pattern). Config entity `dfp.tag.*` (`Drupal\dfp\Entity\Tag`).
- Rendering: `dfp.html_response.attachments_processor` decorates core
  `html_response.attachments_processor`; acts on `dfp_slot` attachments (`DfpHtmlResponseAttachmentsProcessor`).
- One permission: `administer DFP` (create/edit/delete tags + configure display). Routes in
  `dfp.routing.yml` all require it; also `dfp.test_page` at `/admin/structure/dfp/test_page`.
- Blocks: a block derivative per tag (`Plugin/Block/TagBlock`); place via core Block UI.
- Note: the Drupal 7 "inject arbitrary JavaScript" admin field was **not** re-implemented in 8+/3.x
  (see `AdminSettings::buildForm` @todo). Targeting values are Twig-autoescaped in the inline scripts.
