<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# social_share_link plugin type

## Manager & discovery
`social_share.link_manager` → `Drupal\social_share\SocialShareLinkManager` (extends
`DefaultPluginManager`, uses `CategorizingPluginManagerTrait`). Constructor args
`['@container.namespaces', '@module_handler']`. Discovery: annotated classes under
`Plugin/SocialShareLink`, interface `SocialShareLinkInterface`, annotation
`Drupal\social_share\Annotation\SocialShareLink`; alter hook `social_share_link`. Access the manager
in code via `SocialShareLinkManagerTrait::getSocialShareLinkManager()` or
`\Drupal::service('social_share.link_manager')`.

## Annotation (`SocialShareLink`)
Keys: `id`, `label`, `category`, and `context` / `context_definitions` — an array of
`@ContextDefinition` keyed by context name. Context defaults, requiredness and labels drive both the
config form and the template variables.

## Interface (`SocialShareLinkInterface extends PluginInspectionInterface, ContextAwarePluginInterface`)
- `build($template_suffix = '', $render_context = [])` — returns a render array `#theme =>
  <templateName><suffix>`, plus `#<contextName>` for every set context value, an empty `Attribute`
  under `#attributes`, and `#render_context`.
- `getTemplateInfo()` — returns a `hook_theme()`-style array registering the plugin's template, with
  every context name as a variable (default = context default). Most plugins also register the
  `social_share_preprocess_template_urls` preprocess function (all except mail and linkedin).

Default plugins all extend `PluginBase` + `ContextAwarePluginTrait` and only set a
`$templateName`; the `build()`/`getTemplateInfo()` bodies are identical across them.

## Default plugins (id → template → notable context)
- `social_share_facebook` → `social_share_link_facebook` — `facebook_app_id`, `facebook_link_text`,
  `title`, `description`, `caption`, `url` (uri), `media_url`, `media_image_url`, `facebook_ref`.
- `social_share_twitter` → `social_share_link_twitter` — `twitter_link_text`, `shared_text`,
  `hashtags`, `twitter_url` (uri, honours `<current>`), `twitter_via`, `twitter_related`,
  `twitter_reply_to` (int).
- `social_share_linkedin` → `social_share_link_linkedin` — `linkedin_link_text`, `linkedin_url`
  (uri, honours `<current>` inside the template), `linkedin_title`, `linkedin_summary`,
  `linkedin_source`.
- `social_share_pinterest` → `social_share_link_pinterest` — `pinterest_link_text`, `title`,
  `image_url`, `url` (uri), `hashtags`.
- `social_share_whatsapp` → `social_share_link_whatsapp` — `whatsapp_link_text`,
  `whatsapp_link_message`, `url` (uri, required).
- `social_share_mail` → `social_share_link_mail` — `mail_link_text`, `mail_subject`, `mail_body`
  (rendered as a textarea in the config form).
- `link_print` → `social_share_link_print` — `print_link_text`, `url` (uri), `print_url_query_parameter`
  (default `print=1`).
- `link_pdf` → `social_share_link_pdf` — `pdf_link_text`, `url` (uri), `pdf_url_query_parameter`
  (default `pdf=1`).

## Merging context across plugins
`SocialShareLinkManager::getMergedContextDefinitions(array $plugin_ids)` returns
`[$used_context, $used_by_plugins]`: the union of all plugins' context definitions keyed by name,
plus a map of context-name → plugin IDs using it. Contexts sharing a name are configured once and
the same value is passed to every plugin that declares it (README advises prefixing plugin-specific
contexts, e.g. `facebook_`). No data-type reconciliation is done (see the class `@todo`).

## Adding a custom provider
Create `src/Plugin/SocialShareLink/MyShareLink.php` extending `PluginBase` with
`ContextAwarePluginTrait`, implement `SocialShareLinkInterface`, annotate with `@SocialShareLink`
(prefix the id with your module name), set `$templateName`, and provide the matching Twig template
plus its `getTemplateInfo()` registration.
