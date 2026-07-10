# CLAUDE.md — SwiftChart

> This file is the source of truth for all agents working on this project.
> It defines the tech stack, conventions, repo structure, and agent context.
> All agents must read this file before starting any task.

---

## Project Overview

A simple line and area charting library for iOS, distributed as a Swift Package (and,
historically, a CocoaPod). See `docs/product/mvp-scope.md` for full product scope.

---

## Platforms & Tech Stack

| Layer | Technology | Notes |
|-------|-----------|-------|
| Library (`Source/`) | Swift, UIKit, Swift Package Manager | iOS 18.0+, no runtime dependencies |
| Demo app (`demo/`) | Swift, UIKit, Storyboards, XcodeGen | Consumes `SwiftChart` as a local SPM package |

---

## Repository Structure

```
SwiftChart/
├── docs/               # Architecture, ADRs, product, and design docs
├── Source/             # SwiftChart library target
├── Tests/              # SwiftChartTests unit test target
├── demo/               # Demo iOS app (project.yml + XcodeGen)
├── fastlane/           # Fastlane lanes (test, demo_ios_build)
└── .github/workflows/  # CI
```

---

## Architecture

**Pattern:** See `./docs/architecture/`

**Key ADRs:** See `./docs/architecture/`

---

## Coding Conventions

### General
- Follow language-idiomatic style for each component
- Keep functions small and focused

### Git
**Branch Naming:** `{type}/{issue-number}-{short-description}`
**Commit Style:** Conventional Commits (`feat:`, `fix:`, `test:`, `chore:`, etc.)
**Merge Strategy:** Always use **rebase and merge** when merging PRs into `master` to keep a flat, linear history. Do not use merge commits or squash.
**CI gate:** Always wait for CI to pass on the PR before merging into `master`. Never merge a branch with a failing or in-progress CI run.

---

## Testing Conventions

**Approach:** TDD — write failing tests before implementing

| Component | Test Types |
|-----------|-----------|
| `Source/` (spm) | Unit Tests |
| `demo/` | None (build check only, no test target) |

---

## Fastlane & Ruby

Run `bundle install` before invoking any lane for the first time. Available lanes:

- `fastlane ios test` — builds and runs `Tests/SwiftChartTests` against the iOS Simulator.
- `fastlane ios demo_ios_build` — builds `demo/SwiftChartDemo.xcodeproj` against the iOS
  Simulator (build check only; the demo app has no test target).

---

## Living Document

**Every task that encounters a non-obvious problem with a clear solution must update this file.** If an agent hits a recurring pitfall — a build configuration quirk, a platform gotcha, a tooling workaround — and identifies a definitive fix, add a concise note to the relevant section before closing the PR. This prevents future agents from re-discovering the same issues.

---

## Environment & Secrets

**Secret Management:** GitHub Secrets for CI/CD, `.env` files locally (not committed)
