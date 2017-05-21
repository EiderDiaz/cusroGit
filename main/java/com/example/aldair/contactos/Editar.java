package com.example.aldair.contactos;

import android.app.Activity;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class Editar extends AppCompatActivity {

    Button btnEditar, btnCancelar, btnEditarImagen;
    EditText txtNombre, txtTelefono, txtEmail;
    ImageView ivPerfilEditar;
    String rutaImagen;
    private static final int SELECT_FILE = 1;
    String nombreImagen = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_editar);

        btnEditar = (Button) findViewById(R.id.btnEditar);
        btnCancelar = (Button) findViewById(R.id.btnCancelar);
        txtNombre = (EditText) findViewById(R.id.txtNombre);
        txtTelefono= (EditText) findViewById(R.id.txtTelefono);
        txtEmail = (EditText) findViewById(R.id.txtEmail);
        ivPerfilEditar = (ImageView) findViewById(R.id.ivPerfilEditar);
        btnEditarImagen = (Button) findViewById(R.id.btnEditarImagen);

        txtNombre.setText(getIntent().getExtras().get("nombre").toString());
        txtTelefono.setText(getIntent().getExtras().get("telefono").toString());
        txtEmail.setText(getIntent().getExtras().get("email").toString());
        final int posicionContacto = getIntent().getExtras().getInt("posicionContacto");
        rutaImagen = getIntent().getExtras().get("rutaImagen").toString();

        File imgFile = new  File(rutaImagen);
        if(imgFile.exists()){
            Bitmap myBitmap = BitmapFactory.decodeFile(imgFile.getAbsolutePath());
            ivPerfilEditar.setImageBitmap(myBitmap);
        }

        btnEditarImagen.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                abrirGaleria(v);
            }
        });

        btnEditar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Bitmap imagen = ((BitmapDrawable)ivPerfilEditar.getDrawable()).getBitmap();
                guardarImagen(getApplicationContext(), nombreImagen, imagen);
                Intent i =  getIntent();
                i.putExtra("nombre", txtNombre.getText().toString());
                i.putExtra("telefono", txtTelefono.getText().toString());
                i.putExtra("email", txtEmail.getText().toString());
                i.putExtra("posicionContacto", posicionContacto);
                i.putExtra("rutaImagen",rutaImagen);
                setResult(RESULT_OK, i);
                finish();
            }
        });

        btnCancelar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setResult(RESULT_CANCELED);
                finish();
            }
        });
    }

    public void abrirGaleria(View v){
        Intent intent = new Intent();
        intent.setType("image/*");
        intent.setAction(Intent.ACTION_GET_CONTENT);
        startActivityForResult(
                Intent.createChooser(intent, "Seleccione una imagen"),SELECT_FILE);
    }

    protected void onActivityResult(int requestCode, int resultCode,
                                    Intent imageReturnedIntent) {
        super.onActivityResult(requestCode, resultCode, imageReturnedIntent);
        Uri selectedImageUri = null;
        Uri selectedImage;

        String filePath = null;
        switch (requestCode) {
            case SELECT_FILE:
                if (resultCode == Activity.RESULT_OK) {
                    selectedImage = imageReturnedIntent.getData();
                    nombreImagen = selectedImage.getLastPathSegment();
                    //Toast.makeText(this, nombreImagen, Toast.LENGTH_SHORT).show();
                    if (requestCode == SELECT_FILE) {

                        if (selectedImage != null) {
                            InputStream imageStream = null;
                            try {
                                imageStream = getContentResolver().openInputStream(
                                        selectedImage);
                            } catch (FileNotFoundException e) {
                                e.printStackTrace();
                            }

                            // Transformamos la URI de la imagen a inputStream y este a un Bitmap
                            Bitmap bmp = BitmapFactory.decodeStream(imageStream);

                            // Ponemos nuestro bitmap en un ImageView que tengamos en la vista
                            //ImageView mImg = (ImageView) findViewById(R.id.ivImagen);
                            ivPerfilEditar.setImageBitmap(bmp);

                        }
                    }
                }
                break;
        }
    }

    File dirImages;
    private String guardarImagen (Context context, String nombre, Bitmap imagen){
        ContextWrapper cw = new ContextWrapper(context);
        dirImages = cw.getDir("Imagenes", Context.MODE_PRIVATE);
        File myPath = new File(dirImages, nombre +".png");
        rutaImagen = myPath.getAbsolutePath();
        // Toast.makeText(this, myPath.getAbsolutePath() +" <-------", Toast.LENGTH_SHORT).show();
        FileOutputStream fos = null;
        try{
            fos = new FileOutputStream(myPath);
            imagen.compress(Bitmap.CompressFormat.JPEG, 10, fos);
            fos.flush();
        }catch (FileNotFoundException ex){
            ex.printStackTrace();
        }catch (IOException ex){
            ex.printStackTrace();
        }
        return myPath.getAbsolutePath();
    }

}
