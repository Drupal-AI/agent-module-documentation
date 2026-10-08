# PM Carousel + Tobii Lightbox — manual setup guide

**PM Carousel + Tobii Lightbox** (`pm_carousel_tobii`) connects the **PM Carousel**
accessible slider to the **Tobii** lightbox library. With it, images shown in a PM
Carousel open in a Tobii lightbox when clicked — combining the two libraries into a
carousel-with-lightbox image gallery.

It is a presentation/content-display feature and has no access-control role of its
own. It depends on two other modules — **PM Carousel Accessible Slider**
(`pm_carousel`) and **Lightbox Tobii Image Formatter** (`lightbox_tobii`) — and on
two external JavaScript libraries (PM Carousel and Tobii) that must be present on
disk. Composer installs both libraries automatically from the maintainers' mirror
fork.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, its dependencies
   and the two JavaScript libraries, then enable it.

There is **no configuration page** for this module — it has no settings form. Once
enabled, it glues PM Carousel and Tobii together; build your carousel gallery
through PM Carousel and its Views/field display as usual.

## Where it lives in the admin menu

PM Carousel + Tobii adds no admin settings page. It works by making the carousel's
images open in the Tobii lightbox wherever a PM Carousel is displayed.
