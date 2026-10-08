# Simplenews Resend — manual setup guide

**Simplenews Resend** (`simplenews_resend`) lets you send a Simplenews newsletter
issue again after it has already gone out. It works by resetting an issue's "sent"
status back to "not sent", so Simplenews will let you queue and send it once more —
to the same list or a different one.

Simplenews treats an issue as sent once, which is the right default, but it leaves
three ordinary situations unhandled. A **correction** — the newsletter went out with
the wrong date on an event and the recipients need the right one. A **late addition**
— people who subscribed after the send should still receive the issue, which matters
for a welcome sequence or an archive-on-signup arrangement. And a **partial failure**
— the mail queue stalled part-way through and nobody knows which subscribers actually
received it. Without a resend the workarounds are all bad: duplicating the issue loses
the link to the original, editing and re-queueing risks sending twice to everyone,
and doing nothing leaves the correction unmade. This module adds the missing action.

It depends on **Simplenews** and adds no settings page of its own — once enabled, the
ability to reset an issue's sent status appears alongside the newsletter issue. There
is nothing to configure.

**A resend is a bulk send, so the ways it goes wrong are the ways bulk sends go
wrong, made sharper by the fact that these recipients have already had one email.**
Three things are worth getting right each time. **Know who you are sending to** — the
same list, only new subscribers, or only those who failed — because "resend" without
that distinction means everyone gets it twice, which for a correction is exactly the
outcome you were trying to avoid. **Say it is a correction in the subject line**,
since a newsletter that looks like a duplicate is deleted unread and the correction
goes unmade. And **honour unsubscribes against the current list**, not the list
captured at the original send, or the resend reaches people who have since opted out —
the failure that turns a correction into a complaint.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

After enabling, open the Simplenews newsletter issue you want to send again. The
module lets you reset that issue's sent status from "sent" back to "not sent"; once
reset, you use Simplenews's normal send controls to queue and deliver it again.
Before you do, decide who the recipients should be, flag the subject as a correction
where relevant, and make sure current unsubscribes are respected.
