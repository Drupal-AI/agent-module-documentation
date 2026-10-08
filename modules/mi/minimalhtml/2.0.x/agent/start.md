<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Minimal HTML — agent index

A **minimal WYSIWYG text format** for admin-configurable text areas (basic formatting only — bold/links/
lists). `minimalhtmltitle` submodule. Version **2.0.5**. Core `^8||^9||^10||^11||^12`.

Content-editing/text-format — a **restricted** format (limited allowed tags = safer/less XSS surface for
admin/config text). Allowed tags determine the XSS surface; keep minimal. No access role.
