# Music Journal App 🎵📖

A Ruby on Rails web application that allows users to log their music listening habits, view genre distribution, track favorites, and export logs as PDFs.

![image](https://github.com/user-attachments/assets/8d52d7d5-cee3-4ffa-9b88-a425b8b906fd)

# Features
- User Authentication via Devise
- Music Log Management (Add, Edit, Delete)
- Favorite Songs and View Friends' Favorites
- Genre Distribution Pie Chart via Chartkick + Google Charts
- PDF Exporting via Prawn
- Filtering Logs (Today, Last Week, Last Month)

# Technologies Used
## Backend
- Ruby on Rails (Full-stack app)
- PostgreSQL (Database)
- Devise (User Authentication)
- Prawn (PDF Generation)
- Chartkick + Google Charts (For Genre Distribution Pie Chart)
## Frontend
- ERB + TailwindCSS (UI Styling)
- Hotwire/Turbo
## Testing
- Capybara + RSpec (Integration & Feature Testing)

# Installation & Setup
1. Clone Repository
git clone https://github.com/borciftci/music-journal.git
cd music-journal
2. Install Dependencies
bundle install
3. Set Up the Database
rails db:create db:migrate db:seed
4. Run the Server
rails server

Then, open http://localhost:3000 in your browser.

# Running Tests
bundle exec rspec

# Deployment
The app can be deployed to Heroku, Render, or AWS. 

# Known Issues & Future Improvements
Pie Chart requires both chartkick and googlecharts
- Having chartkick without googlecharts gives a "Library not found" error.
- Having only googlecharts makes the chart stay stuck on "Loading..."

Planned Features (Future)
- Redis for caching (Genre distribution chart)
- Sidekiq for background jobs (e.g., Weekly summary emails)

# Contributing
If you'd like to contribute:

1. Fork the repo
2. Create a feature branch (git checkout -b feature-branch)
3. Make changes & commit (git commit -m "Added feature")
4. Push to your fork (git push origin feature-branch)
5. Open a Pull Request 🚀

# License
MIT License © borciftci (2025) 






