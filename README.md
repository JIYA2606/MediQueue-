# MediQueue — Smart Medical Bed Queue Management System

MediQueue is a responsive student PBL prototype that demonstrates priority-based patient queues and bed allocation. It uses fictional sample records and is not a clinical system. Staff enter the priority; the software does not diagnose or determine medical priority.

## Features

- Demo staff login (`staff` / `demo123`)
- Dashboard with live bed counts, ward occupancy and waiting queue
- Patient registration with validation and priority/FIFO ordering
- Bed management: add, filter and update beds
- Ward-matched allocation, admission records and discharge
- Patient search by ID or name
- Activity history and a DSA visualization page
- Demo state saved in browser local storage
- Optional Node.js server and a starter MySQL schema

## Data structures

- **Priority queue:** orders waiting patients by staff-entered priority (Emergency, Critical, Serious, Stable) and then registration time. Queue order is computed by the data structure and is not manually editable.
- **Hash table:** uses patient ID as the key for lookup. Separate buckets handle collisions.
- **Linked list:** appends activity records through a tail pointer and traverses them for the history display.

The classes are at the top of `app.js`, separate from rendering and event handlers so they are easy to discuss in a viva. The queue demo illustrates P102 → P104 → P103 → P101.

## Technology

HTML, CSS, browser JavaScript, Node.js and Express. `schema.sql` is a MySQL starter schema; `server.js` exposes a small optional database health check. The UI currently keeps its demo records in local storage, so it runs without MySQL.

## Run locally

1. Install Node.js 18 or later.
2. In this directory, run `npm install`.
3. Run `npm start`.
4. Open `http://localhost:3000` and sign in with `staff` / `demo123`.

To check optional MySQL connectivity, create the database from `schema.sql`, then set `DB_HOST`, `DB_PORT` (optional), `DB_USER`, `DB_PASSWORD` and `DB_NAME` before starting the server. Visit `/api/health` to see the connection status. The current UI remains in demo/local-storage mode; database-backed application routes are a future integration step.

## Publish on GitHub Pages

The static demo is configured to deploy from the `main` branch with the workflow in `.github/workflows/pages.yml`. In the GitHub repository, open **Settings → Pages**, set the publishing source to **GitHub Actions**, and save. Each push to `main` then publishes the website. GitHub Pages hosts the HTML/CSS/browser JavaScript only; it does not run the Node server or connect to MySQL.

## Project structure

```text
├── index.html     # app shell and login
├── styles.css     # responsive dashboard and component styles
├── app.js         # DSA classes, sample state, UI and demo workflows
├── server.js      # local Express static server and optional DB health route
├── schema.sql     # MySQL starter tables and indexes
├── package.json
├── README.md
└── .github/workflows/pages.yml # GitHub Pages deployment
```

## Future scope

- Add authenticated staff accounts and role-based permissions.
- Connect the patient, bed, admission and history workflows to MySQL transactions and a REST API.
- Add audit controls, privacy protections and accessibility review before any real-world adaptation.
- Extend the queue to a heap-backed implementation if the project needs more efficient insertion and retrieval at larger scale.
