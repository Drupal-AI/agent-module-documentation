<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring subsites

1. Enable `subsite` (pulls in book, social_media_links).
2. Add the **Subsite** field to node types that should act as subsite roots.
3. Visit `/admin/structure/subsite/settings` (`administer site configuration`) to configure allowed types and defaults.
4. Overview of existing subsites: `/admin/structure/subsite` (`administer subsite settings`).
5. On a node form, users with `administer subsite configuration` (or `maintain subsite` for allowed types) see the subsite element.

**Plugins** (`src/Plugin/Subsite/`): `ThemeSubsitePlugin`, `BrandingSubsitePlugin`, `BookSubsitePlugin`, `SocialMediaPlugin`. Implement `SubsitePluginInterface` / extend `BaseSubsitePlugin` to add features. The theme negotiator (`theme.negotiator.subsite`, priority -40) switches the active theme inside a subsite; the `subsite` cache context varies rendered output.

**Blocks:** `SubsiteSocialLinksBlock`, `SubsiteFooterLinksBlock`, `BookMainNavigationBlock`.
