# 1. Use uma imagem oficial do Python como imagem base.
# A variante 'slim' é um bom compromisso entre tamanho e a disponibilidade das bibliotecas de sistema necessárias.
FROM python:3.11-slim

# 2. Defina o diretório de trabalho no contêiner.
WORKDIR /app

# 3. Copie o arquivo de dependências primeiro para aproveitar o cache de build do Docker.
# Esta camada só é reconstruída se o requirements.txt mudar.
COPY requirements.txt .

# 4. Instale as dependências.
# A flag --no-cache-dir reduz o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copie o restante do código da aplicação para o contêiner.
COPY . .

# 6. Exponha a porta em que a aplicação será executada.
EXPOSE 8000

# 7. O comando para executar a aplicação.
# O host 0.0.0.0 é importante para tornar o servidor acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
