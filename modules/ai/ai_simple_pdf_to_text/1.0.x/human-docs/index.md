# AI Simple PDF to Text — manual setup guide

**AI Simple PDF to Text** (`ai_simple_pdf_to_text`) adds AI **automators** and
**agents** that convert PDF documents into plain text. It plugs into Drupal's
AI framework so that other AI workflows — indexing, summarizing, classification,
or any further processing — can work with the text pulled out of a PDF rather
than the binary file.

The typical way to convert a PDF is to send its content to the AI provider the
site is configured to use. That means the document leaves your site and reaches
an external service, so it is a **data-handling consideration for sensitive or
confidential PDFs**: do not run documents through it that you are not allowed to
share externally. Any provider API key is stored as a secret in the AI module's
configuration, not by this module.

The module has no access-control role of its own — where the conversion runs
and who can trigger it depends on the automator or agent workflow you wire it
into.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside the AI module.

## Where it lives in the admin menu

There is no dedicated settings page. The module contributes **automator and
agent plugins** that appear inside the AI module's automator/agent tooling
(under **Configuration → AI**, `/admin/config/ai`). You use it by selecting the
PDF-to-text automator when you build an AI automator or agent chain.

## How to use it

Add the PDF-to-text step to an AI automator or agent workflow — for example, an
automator that takes an uploaded PDF field, extracts its text, and feeds that
text to a summarization or indexing step. Because extraction sends the PDF to
the configured provider, only point it at documents you are comfortable sending
externally, and keep the provider key stored as a secret.
