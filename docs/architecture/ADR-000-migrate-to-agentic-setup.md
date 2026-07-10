# ADR-000 — Migrate to Agentic Setup

**Date:** 2026-07-10
**Status:** Accepted
**Author:** Architect
**Deciders:** Marek Loose

---

## Context

SwiftChart existed as a working, already-published Swift Package with a legacy CocoaPods-based
demo app, but with none of the surrounding structure (`docs/`, `project.yml`/XcodeGen, Fastlane,
GitHub Actions, `architecture.json`) that the Agentic development workflow expects for every
project. Bringing it up to that standard lets downstream `phase-3`/`phase-4`/`phase-5` tooling
operate on this repo the same way it would on a project scaffolded from scratch.

---

## Decision

Migrate the repository in place using `migrate-existing-project`: rename the demo app folder
from `Example/` to `demo/`, add a starter unit test target to the package, regenerate the demo
app via XcodeGen with a local SPM package dependency (replacing CocoaPods), and add
reverse-engineered docs, Fastlane, and GitHub Actions.

---

## Options Considered

### Option 1: Migrate in place (chosen)

**Description:** Restructure the existing repository directly, using small, individually
committed steps with a rollback tag.

**Pros:**
- Preserves git history via `git mv`
- No disruption to the published package's consumers (root `Package.swift` stays at repo root)

**Cons:**
- Requires care not to break the working demo app or library during restructuring

### Option 2: Start a fresh repository and port code over

**Description:** Scaffold a brand-new Agentic project via `phase-2-setup` and copy source files
across.

**Pros:**
- Guarantees a byte-for-byte standard scaffold

**Cons:**
- Loses git history/blame
- Unnecessary churn for a project that already works and has an established GitHub repo/URL

---

## Rationale

The project already has a working library, a real GitHub repo with history, and (until this
migration) no docs or CI — migrating in place is strictly additive/restructuring work, not a
rewrite, so Option 1 preserves everything that already works while closing the gap with a
freshly-scaffolded project.

---

## Consequences

**Positive:**
- `docs/architecture/architecture.json` now exists, enabling downstream `solo_dev_plugins`
  skills to operate on this repo without special-casing
- CI and Fastlane now exercise the package's build/test on every push

**Negative / Trade-offs:**
- This skill's templates are intentionally duplicated from `phase-2-setup`'s templates rather
  than shared at runtime (each plugin is self-contained) — the accepted trade-off is that the
  two copies must be kept in sync manually when either is edited (tracked at the plugin level,
  not in this repo)
- The demo app's dependency mechanism changed (CocoaPods → local SPM), which is a real
  behavioral change or reviewers/contributors should note

**Risks:**
- None expected — the demo app was verified to build successfully via `xcodebuild` after
  regeneration before the old CocoaPods artifacts were deleted

---

## Related

| Type | Reference |
|------|-----------|
| Supersedes | |
| Related ADRs | ADR-001, ADR-002 |
| Related issues | |
