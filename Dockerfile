FROM bitnami/laravel
RUN apt-get update

RUN apt-get update && apt-get install curl git -y && apt-get install sudo -y && apt-get install wget -y

RUN curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh &&\
   bash nodesource_setup.sh
RUN apt-get update && apt-get install nodejs -y
RUN apt-get install vim -y

RUN git clone -b displaying_dummy_data_in_a_table  https://github.com/benboubekeur/educative-chapter-how-does-it-work &&\
    cd educative-chapter-how-does-it-work && npm install && composer i && touch database/database.sqlite

RUN	git clone https://github.com/benboubekeur/educative-vite-1.git &&\
	cd educative-vite-1 && npm install
