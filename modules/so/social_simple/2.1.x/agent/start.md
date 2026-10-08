# Social Simple — agent index

Simple social share links (Twitter/X, Facebook, LinkedIn, Google+, Mail, Print, Entity-Print PDF)
for nodes and taxonomy terms, shown as a per-content-type display element or a block. No hard
dependencies. No config page (`configure` null) — configured on the content-type form and per block.
Provides one permission, a config schema, a theme hook, and a JS library.

- **Turn on sharing per content type, the block, hashtags source, per-node hiding, display element** →
  [configure/setup.md](configure/setup.md)
- **Add or override a social network (tagged `social_simple_network` service) + the generator API** →
  [extend/network.md](extend/network.md)

Submodule (not enabled by default; ships in-tree):
- `social_simple_per_node` — boolean `social_share` base field + node-form checkbox; permission
  `disable social links per node`. Covered inline in configure/setup.md.

Key facts:
- Shipped network service ids: `social_simple.twitter`, `.facebook`, `.linkedin`, `.googleplus`,
  `.mail`, `.printer`, `.entity_print_pdf` (all tagged `social_simple_network`, priority 0).
- Generator service `social_simple.generator`; manager `social_simple.manager`
  (service_collector, `addNetwork`).
- Permission `administer social simple`. Block plugin `social_simple_block`. Theme hook
  `social_simple_buttons` (template `templates/social-simple-buttons.html.twig`, suggestion
  `__<node_type>`). Library `social_simple/buttons` (+ FontAwesome from jsDelivr CDN).
- Content-type third-party settings under `social_simple`: `share`, `title`, `networks`,
  `hashtags`, `forward_integration`.
