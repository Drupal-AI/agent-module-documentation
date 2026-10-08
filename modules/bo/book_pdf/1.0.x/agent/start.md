<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Book PDF — agent index

**Prints an entire Book to a PDF file** (renders the book page tree). Depends on core `book`. Provides
permissions. Version **1.0.x** (dev). Core `^8||^9||^10||^11`.

**Download route:** `/book-pdf/{book}/send` (`access content` + `entity:node` param); `sendPdf()` →
`getFileUri()` generates (on demand, then cached) and returns the PDF of the book and its child pages.
