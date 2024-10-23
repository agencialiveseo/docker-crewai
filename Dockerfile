FROM python:3.11-bookworm

WORKDIR /app 

COPY ./app.py /app/app.py

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN pip install 'crewai[tools]'

CMD python /app/app.py