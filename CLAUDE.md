# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

This is the `Injected45.github.io` GitHub Pages repo. Its git history (branch `main`) contains **only the
static, pre-rendered output of a Nuxt 3 site** (Vite-hashed chunks under `_nuxt/`, plus a fully rendered
`index.html` and a `_payload.json` next to every route for client-side hydration) — there is no `package.json`,
`nuxt.config`, source tree, or build tooling committed here. The Nuxt *source project* that produces this
output lives elsewhere and is not part of this repo.

The site is for **شركة الرحالة للصرافة** ("Al-Rahalla Exchange Company"), a Libyan currency-exchange /
money-transfer business, served (per `sitemap.xml` / canonical tags) at `https://rhalla.com/`. Content is
Arabic/RTL. There's no CNAME file in the tree, so the custom domain (if still active) is configured outside
the repo, at the GitHub Pages / DNS level.

## Working-tree caveat — read before touching files

**The working tree does not match `HEAD` on this branch.** `git status` shows nearly every tracked file
(all of `_nuxt/`, `branches/`, `currencies/`, `moneygram/`, `western-union/`, `live-pricing/`,
`transfer-inquiry/`, `booking-cards/`, `images/`, etc.) as deleted on disk, and the top level currently holds
a large amount of *untracked* content unrelated to this Nuxt site. Before assuming any top-level file or
folder is part of the deployed exchange-company site, check `git status` / `git show HEAD:<path>` rather
than trusting what's currently on disk — the two can disagree substantially.

## There is no build/lint/test here

Because only generated output is committed, there's nothing to `npm install`, build, lint, or test in this
repo. To change the site's actual content/behavior you need the upstream Nuxt source project; this repo just
needs the corresponding pre-rendered output copied in and committed. Hand-editing the static `index.html`
files directly is possible for trivial text/meta tweaks, but:

- Each route's `index.html` and its sibling `_payload.json` must stay in sync — the payload carries the
  serialized data Vue uses to hydrate the static markup (e.g. `_payload.json`: `[{"data":1,...},["ShallowReactive",2],{},<timestamp>]`).
  Editing one without the other will desync hydration.
- Asset filenames under `_nuxt/` are content-hashed (Vite output, e.g. `entry.BN3NcFtt.css`,
  `DAw4lS-v.js`); `_nuxt/builds/latest.json` and `_nuxt/builds/meta/<uuid>.json` record the current Nuxt
  build id/timestamp. Don't rename or hand-edit these — they're only ever meant to be replaced wholesale by
  a fresh `nuxt generate`/build output.

## Site structure (route ↔ file mapping)

Nuxt's static export gives one directory per route, each with `index.html` (rendered page) and
`_payload.json` (hydration data). Routes present in `HEAD`:

| Path | Purpose |
|---|---|
| `/` (`index.html`) | Home page |
| `/branches` | Company branch locations (uses a Leaflet map — see `_nuxt/leaflet.*.css`) |
| `/currencies` | Daily currency exchange rates (chunk name `cbl-display.*` suggests Central Bank of Libya rate display) |
| `/live-pricing` | Live pricing page |
| `/western-union/transfer`, `/western-union/track` | Western Union send / track-transfer flows |
| `/moneygram/transfer`, `/moneygram/track` | MoneyGram send / track-transfer flows |
| `/transfer-inquiry` | Generic transfer inquiry page |
| `/booking-cards`, `/booking-cards/track` | Card booking + booking tracking |

Shared static assets: `images/` and `images_refernces/` (note the typo in the second directory name — it's
intentional/pre-existing, not a mistake to "fix" in isolation) hold logos and partner-bank images (e.g.
`ncb-dark.png` / `ncb-light.png`). `favicon.ico`, `robots.txt`, `sitemap.xml`, and a Google site-verification
file (`google76733116dbb6ccd6.html`) sit at the root alongside the generated output.
