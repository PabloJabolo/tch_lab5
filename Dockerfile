#1. BUDOWANIE APLIKACJI
# Wykorzystanie obrazu node w wersji 16-alpine jako bazowego - do budowania
FROM node:16-alpine as builder

# ARG: Parametr APP_VERSION używany do przekazania wersji obrazu
ARG APP_VERSION
# ENV: Definicja zmiennej środowiskowej APP_VERSION i przypisanie wartości z parametru APP_VERSION
ENV APP_VERSION=${APP_VERSION}

# Ustawienie katalogu roboczego na "/app"
WORKDIR /app

# Skopiowanie plików package.json i package-lock.json do kontenera
COPY my-app/package*.json ./

# Instalacja zależności przy użyciu polecenia "npm ci"
# Wykorzystałem to polecenie by przyspieszyć proces budowania obrazu
RUN npm ci

# Skopiowanie pozostałych plików aplikacji do kontenera
COPY my-app/public ./public
COPY my-app/src ./src

# Zbudowanie aplikacji przy użyciu polecenia "npm run build"
RUN npm run build




#2. WYSTAWIENIE APLIKACJI

# Wykorzystanie obrazu apache w wersji 2.4-alpine
FROM httpd:2.4-alpine

# Przekazanie parametru APP_VERSION i ustawienie zmiennej środowiskowej APP_VERSION
ARG APP_VERSION
ENV APP_VERSION=${APP_VERSION}

# Skopiowanie zbudowanej aplikacji do katalogu "/usr/local/apache2/htdocs" w obrazie apache
COPY --from=builder /app/build /usr/local/apache2/htdocs

# Wystawienie aplikacji na porcie 80
EXPOSE 80

# Uruchomienie serwera apache w trybie FOREGROUND
CMD ["httpd", "-D", "FOREGROUND"]
