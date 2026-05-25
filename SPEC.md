# David Roberts Photography — Site Spec

## Concept
A minimalist photography portfolio. Vertical scrolling drives a HORIZONTAL "Rolodex"
effect: as you scroll down, photo cards slide across the screen left-to-right, one at a
time, like flipping through an archive. White background, thin charcoal spine line,
Century Gothic font, no em dashes anywhere.

## Scenes (12 total, in order)
0. Intro (title: "David Roberts" + tagline)
1-9. Nine photo entries (image + caption: micro label, headline, caption line)
10. About
11. Contact / booking

A horizontal "spine" line sits across the screen. Each scene's image sits ABOVE the
spine; its text sits BELOW the spine. A small vertical connector ties the image to the spine.

## Scroll model
- Page scrolls vertically (native). `progress = scrollY / step`.
- `step` = how much scroll = one scene advance.
- At progress=0 you're on intro; progress=11 you're on contact.
- As progress changes, each scene translates horizontally via `--h-x` (CSS var set by JS).
- Active scene is centered (h-x=0, opacity 1). Neighbors slide off to the sides and fade.

## DESKTOP (width > 820px) — THIS MUST STAY GOOD
- Image is LARGE and dominant: roughly 50-60% of viewport WIDTH, centered horizontally.
- Spine at 80% of viewport height (`--h-spine-y: 80%`).
- Image sits above spine, caption (micro + headline + caption) to the side/below per design.
- step = innerHeight * 0.88
- Custom cursor (dot + ring), 2.5D tilt on hover, dial readout — desktop only.
- Photo frame sizing: width-driven (big), NOT height-capped tiny.

## MOBILE (width <= 820px)
- Single column. Image centered in the zone ABOVE the spine. Caption below spine, full
  width, left-aligned, readable (#5f5f5f, ~0.95rem).
- Spine ~67% down.
- step = innerHeight * 0.52 (BUT use locked APP_VH so toolbar show/hide doesn't shift it).
- Image: fills the zone above spine, centered, object-fit cover, landscape-ish.
- Snap: after scroll fully stops, ease to nearest scene. Never fights momentum.
- No custom cursor / tilt / dial.
- Atmosphere: blurred bg of active image, very subtle.

## CRITICAL: mobile and desktop must NOT break each other
- Mobile rules live ONLY inside `@media (max-width: 820px)`.
- Desktop rules must NEVER be overridden by a global/mobile value (e.g. APP_VH, --spine-px
  computed for mobile leaking into desktop).
- The JS `frameHorizontal` runs for both; `mobile = isMobile()` branches behaviour.
- `APP_VH` lock is a MOBILE concern (toolbar). On desktop, use real innerHeight.

## iOS / mobile gotchas (confirmed)
- NO `scroll-behavior: smooth` (breaks window.scrollTo on iOS Safari 15.4+).
- NO `scroll-snap-type` (fights momentum).
- Use `window.scrollTo(0, y)` 2-arg form only.
- Lock viewport height at load on mobile (toolbar show/hide changes innerHeight).
- overscroll-behavior: none on body.

## Invariants to check before every deploy
1. JS `node --check` passes.
2. Exactly one <script> and one </script>.
3. 9 `<article class="entry">`.
4. Zero em dashes (\u2014).
5. Desktop photo frame is LARGE (width >= 45vw).
6. Mobile photo + caption both fit within the visible viewport.
7. Can scroll from intro all the way to contact (progress reaches 11).
8. No `scroll-behavior: smooth`, no `scroll-snap-type`.
9. pt.html rebuilt from index.html, both copied to .deploy/.

## Deploy
- Edit index.html (source of truth).
- Rebuild pt.html via the Python script (swaps EN->PT content, strips em dashes).
- `cp index.html pt.html .deploy/`
- git add/commit/push -> Cloudflare auto-deploys in ~20s.
