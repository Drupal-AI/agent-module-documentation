# SmartLinker AI — manual setup guide

**SmartLinker AI** (`smartlinker_ai`) adds an AI-powered feature to the CKEditor 5
rich-text editor that generates **contextual internal links** for you. While
editing content, an author selects some text, opens the editor's AI Assistant
dropdown, and chooses *Generate internal links*; the AI then scans the selection
against your site's indexed pages and weaves relevant internal links into the text.

The problem it targets is the manual, easily-forgotten work of internal linking —
the kind that matters for SEO, for helping visitors navigate, and for keeping
linking consistent across a large site. SmartLinker AI automates it directly inside
the editor, so authors can add strategic internal links without leaving CKEditor or
hand-searching for target pages.

In use, the author writes or pastes content, highlights the passage to enrich
(the maintainers suggest not exceeding roughly 1,500 words at a time for good link
quality), and opens the *Generate internal links* dialog. There they can set target
content types and focus keywords, preview the selected text, generate the links,
review the enhanced result, and save it back into the editor.

Because the feature relies on AI plus vector search over your content, it has real
prerequisites and real running costs: it builds on the **AI CKEditor**
(`ai_ckeditor`) and **AI Search** (`ai_search`) modules, and expects a configured
AI provider (such as OpenAI GPT-4o) and a vector database backing AI Search (the
maintainers document Milvus with Zilliz Cloud). Every generation is a paid AI call,
so keep the feature to trusted editors. It provides its own permission and runs on
Drupal 10.3+ and 11.

This guide is written for a **human** setting up and using the editor. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its AI/search
   dependencies with Composer and enable them.
2. [Configuration](configuration/index.md) — stand up the AI Search vector index
   and turn the SmartLinker AI feature on in a text format's CKEditor toolbar.

## How to use it

Once configured (see below), the feature lives in CKEditor's **AI Assistant**
dropdown. Select some text, choose **Generate internal links**, set your target
content types and focus keywords, click **Generate Links**, review, and then **Save
changes to editor**.
