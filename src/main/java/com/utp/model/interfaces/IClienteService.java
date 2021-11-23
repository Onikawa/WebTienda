/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.utp.model.interfaces;

import com.utp.model.entities.Cliente;

public interface IClienteService extends ICRUD<Cliente> {

    @Override
    public void update(Cliente t);

    @Override
    public void insert(Cliente t);
    

    
    Cliente login(String id);

}
