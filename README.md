# Fuzzapi

Fuzzapi is rails application which uses API_Fuzzer and provide UI solution for gem.

### New Scan
<img width="1679" alt="scan body" src="https://cloud.githubusercontent.com/assets/4562611/19390428/12224610-91f6-11e6-9ece-6e3cd7dd35ea.png">

### Scan Result
<img width="1679" alt="scan" src="https://cloud.githubusercontent.com/assets/4562611/19390442/1ef2f3d0-91f6-11e6-91eb-640b17d64a0b.png">

### Scan Histoy
<img width="1679" alt="scan2" src="https://cloud.githubusercontent.com/assets/4562611/19390533/79f83b96-91f6-11e6-9476-c3093b809674.png">

# Setup

1. Install ruby in your machine either using `rvm` or `rbenv`

2. Clone the repository into your localmachine

3. `cd /path/Fuzzapi/bin`, move to Fuzzapi directory

4. `bundle install` to install the gem dependencies of the application

5. `rake db:migrate` to creates tables, migrations etc.

6. `rails s` to run the server

7. Open `http://localhost:3000` in browser which should point to the application url

Fuzzapi comes with `Docker` to simplify installation processing. Following commands will setup application using `Docker`.

1. Clone the repository into your local machine

2. `cd /path/Fuzzapi`, move to Fuzzapi directory

3. Install Docker in your local machine

4. Run `docker-compose build` to build the image locally.

5. Run `docker-compose up` to run the server.

6. Open `http://localhost:3000` in browser which should point to the application url

Fuzzapi uses [API_Fuzzer](https://github.com/lalithr95/API_Fuzzer) gem.
