#!/usr/bin/env node
var http = require("http")
var url = require("url")

http.createServer( function (req, res) {
	var q = url.parse(req.url, true).query;
	var username = q.username
	var password = q.password
	var deviceid = q.device
	try{
		const exec = require('child_process').exec;
		if (username.length >= 3 & password.length >= 3){
			exec('sh app.sh '+ username + ' ' + password + ' 1 180', function(error, stdout, stderr){
				if (error !== null){
					if(error.toString().indexOf("nomevazio") > -1) {
						res.end('Você precisa digitar um nome de usuario valido')
					} else if (error.toString().indexOf("existente") > -1) {
						res.end('Este usuario está em uso')
					} else if (error.toString().indexOf("senhavazia") > -1) {
						res.end('Você precisa digitar uma senha valida')
					} else if (error.toString().indexOf("limitevazio") > -1) {
						res.end('Você precisa digitar um limite valido (apenas numeros)')
					} else if (error.toString().indexOf("tempovazio") > -1) {
						res.end('Você precisa digitar um tempo valido (apenas numeros)')
					} else {
						console.log(error);
					}
				} else {
					res.end('Seu usuário foi criado com sucesso !<br>Login: '+username+'<br>Senha: '+password)
				}
			})
		} else {
			res.end("Seu usuário e sua senha devem conter no minimo 3 caracteres.")
		}
	} catch (e) {
			res.end("Informe o erro ao desenvolvedor: " + e)
	};
}).listen(81, function() {
	console.log("Servidor iniciado.")
})