<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flickr Integration Suite Filter (flickr_integration_suite_filter) — agent index

Submodule of **flickr_integration_suite**. **Text-format filter** expanding a token in body text
into embedded Flickr content. Version **1.0.6**. Core `^10.3 || ^11`.

The editor's placement option. **Filter rather than stored markup** is the right choice: the token
stays in the stored text, so rendering can change (template, photo size, lightbox) without
rewriting content.

**Access control is the text format.** Offer it in the trusted editors' format, withhold it from a
restricted one used for comments or user-submitted content — that is the lever to use if the embed
should not be available everywhere.

Nested submodule: `flickr_integration_suite_filter_colorbox` (Colorbox lightbox; needs
`colorbox`).