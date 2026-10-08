<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drutopia Social is a Drutopia base feature (an aggregator module) whose only job is to depend on core `block` and the contrib `social_media_links` module so a site gains a ready-to-place social media links block.
---
The module ships no PHP, no routes, no services, no permissions and no exported configuration of its own — just an info.yml declaring its dependencies and a `drutopia_social.features.yml` marker (`required: true`) identifying it as a required Drutopia feature. Enabling it therefore pulls in `social_media_links` (and core `block`) and nothing more; all real behaviour — which networks appear, their icons, sizing and order — is configured on the `social_media_links` block once you place it via the standard Block Layout UI at `/admin/structure/block`. It exists so that Drutopia distribution sites get a consistent, opinionated social-links building block out of the box without each site re-selecting the same dependency. Because it contributes no code or config, its security and functional posture are entirely those of its dependencies. This copy was documented from a dev checkout (no tagged release / no `version:` in info.yml).
---
- Add a social media links capability to a Drutopia site by enabling one feature module.
- Guarantee `social_media_links` and core `block` are present on install via the dependency list.
- Provide a ready-to-place "Social media links" block for the Block Layout UI.
- Place the social links block in a footer or header region.
- Choose which networks (Facebook, X/Twitter, Instagram, LinkedIn, etc.) appear — configured on the block.
- Set icon style and size for the social links via the `social_media_links` block settings.
- Reorder the social platforms shown in the block.
- Restrict the block's visibility by path, role or content type using core block conditions.
- Place multiple social blocks in different regions of the same site.
- Keep the social-links building block consistent across many Drutopia sites.
- Use it as an optional/required feature alongside other Drutopia features (e.g. drutopia_core, drutopia_site).
- Theme the block with the active theme's block templates.
- Bootstrap a social presence for a new community or nonprofit site quickly.
- Remove the social links by disabling the module or deleting the block placement.
- Audit which social platforms a site links out to by inspecting the placed block.
- Serve as a template for a "features-style" aggregator module that only carries a dependency set.
