# Automatic Alternative Text — manual setup guide

**Automatic Alternative Text** (`auto_alter`) generates alt text for uploaded
images using a vision service, so images arrive described instead of blank. It
currently supports Microsoft's Cognitive Services Computer Vision API and
Alttext.ai, and the provider is pluggable so others can be added.

Missing alt text is the single most common accessibility failure on
content-managed sites, and it is really a workflow problem rather than a
knowledge one: an editor uploading twenty images to an article is not going to
write twenty descriptions. Automating a first draft changes the economics — the
module sends each image to the configured vision service and fills in a starting
description that editors can accept or improve. An optional submodule,
**`auto_alter_translate`**, extends that generated text into other languages.

Three things belong in any honest recommendation. Generated alt text is a
**draft, not a decision**: vision services describe *what is in* a picture, while
good alt text conveys *why the image is there*, and a purely decorative image
should have empty alt rather than a literal description — an automated describer
will never reach that conclusion, so keep a human in the loop. The service is
**billed per image**, which makes access to generation a spending control. And
each **image is sent to a third party**, which is a data-flow question for any
site handling sensitive, embargoed, or unpublished imagery.

The module keeps API credentials in a dedicated credentials layer. Treat those
keys as secrets: store them in an environment variable (or a Key entity), never
in exported/committed configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the optional translation submodule.
2. [Configuration](configuration/index.md) — choose a provider, supply
   credentials safely, and set the permission that controls who can generate.

## Where it lives in the admin menu

Its settings form sits at **Configuration → Media → Automatic Alternative Text**
(`/admin/config/media/auto_alter`), behind the
`administer Automatic Alternative Text` permission.
