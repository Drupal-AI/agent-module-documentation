<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File PDF Preview — agent index

A field widget that **generates a preview image from an uploaded PDF's first page** (thumbnail vs a file icon).
Depends on core `file`. Version **1.0.0-beta3**. Core `^9||^10||^11`.

Media/field — **processes uploaded PDFs server-side** (page→image via an imaging library, e.g. Imagick/
Ghostscript): keep that library **patched** (PDF tooling has had RCEs), handle untrusted PDFs with care. No
access role.
