module.exports = {
    NODE_ENV:   process.env.NODE_ENV    || 'dev',
    HOST:       process.env.HOST        || 'localhost',
    PORT:       process.env.PORT        || 5000,
    
    /* DB MYSQL */
    DB_HOST:    process.env.DB_HOST     || '34.72.68.114',
    DB_USER:    process.env.DB_USER     || 'root',
    DB_PASS:    process.env.DB_PASS     || 'root',
    DB_NAME:    process.env.DB_NAME     || 'DB_G8',
    DB_PORT:    process.env.DB_PORT     || '3306',
    /* DB MONGO */
    DB_HOST_MONGO:   process.env.DB_HOST_MONGO     || 'admin',
    DB_NAME_MONGO:  process.env.DB_NAME_MONGO     || 'BASES2',
    DB_PASS_MONGO:  process.env.DB_PASS_MONGO     || 'bases2',
}
