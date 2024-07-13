Future<void> dbConnector() async {
  print("Connecting to mysql server...");

  // MySQL 접속 설정
  final conn = await MySQLConnection.createConnection(
    host: host, //아마존 rds 주소
    port: 3306,
    userName: 'root',
    password: 7815, //mysql 비밀번호
    databaseName: 'waterdb', // optional
  );

  // 연결 대기
  await conn.connect();

  print("Connected");

  // 종료 대기
  await conn.close();
}
